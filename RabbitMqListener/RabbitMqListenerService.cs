using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Hosting;
using Newtonsoft.Json;
using RabbitMQ.Client;
using RabbitMQ.Client.Events;
using RabbitMQListener.Extensions;
using RabbitMqListener.Listeners;
using RabbitMqListener.Listeners.TicketSender;

namespace RabbitMQListener;

public class RabbitMqListenerService : BackgroundService
{
    private static readonly IRabbitMqConnectionsPool connectionsPool = new RabbitMqConnectionsPool();

    private readonly List<BaseRabbitMqListenerFactory> listeners;
    private readonly List<IModel> channelsToDispose = new();

    public RabbitMqListenerService(IConfiguration configuration)
    {
        listeners = new List<BaseRabbitMqListenerFactory>
        {
            new TicketSenderListenerFactory(connectionsPool, configuration),
            // new HelloWorldConsumer(),
        };
    }

    protected override Task ExecuteAsync(CancellationToken stoppingToken)
    {
        stoppingToken.ThrowIfCancellationRequested();

        foreach (var listenerFactory in listeners)
        {
            var channel = connectionsPool.Get().CreateModel();
            var eventingBasic = new EventingBasicConsumer(channel);
            
            var consumer = listenerFactory.CreateConsumer();
            
            eventingBasic.Received += async (ch, ea) =>
            {
                var success = await OnReceived(consumer, listenerFactory.QueueName, ch, ea);
                if (success)
                    channel.BasicAck(ea.DeliveryTag, false);
                else
                    channel.BasicNack(ea.DeliveryTag, false, true); // TODO будет бесконечно спамиться, нужно ограничить попытки, делается с помощью заголовков
            };

            channel.BasicConsume(listenerFactory.QueueName, false, eventingBasic);
            channelsToDispose.Add(channel);
        }

        return Task.CompletedTask;
    }

    private static async Task<bool> OnReceived(BaseRabbitMqConsumer consumer, string queueName, object? channel, BasicDeliverEventArgs args)
    {
        try
        {
            var content = Encoding.UTF8.GetString(args.Body.ToArray());

            object? message;
            if (consumer.MessageType == typeof(string))
                message = content;
            else
                message = JsonConvert.DeserializeObject(content, consumer.MessageType);

            if (message is null)
                throw new ArgumentException($"Can't deserialize message to type: {consumer.MessageType}");

            await consumer.Handle(message);
            return true;
        }
        catch (Exception e)
        {
            Console.WriteLine($"Error during execution message from queue: {queueName}. Error: {e.Message}");
            return false;
        }
    }

    public override void Dispose()
    {
        foreach (var channel in channelsToDispose)
            channel.Dispose();

        connectionsPool.Dispose();;
        base.Dispose();
    }
}