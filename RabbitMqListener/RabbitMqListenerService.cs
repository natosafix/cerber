using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.Extensions.Hosting;
using Newtonsoft.Json;
using RabbitMQ.Client;
using RabbitMQ.Client.Events;
using RabbitMQListener.Extensions;
using RabbitMqListener.Listeners;

namespace RabbitMQListener;

public class RabbitMqListenerService : BackgroundService
{
    private static readonly List<BaseRabbitMqListener> listeners = new()
    {
        new TicketSenderListener(),
        new HelloWorldListener(),
    };

    private readonly IConnection connection;
    private readonly List<IModel> channelsToDispose = new();

    public RabbitMqListenerService()
    {
        var factory = new ConnectionFactory {HostName = "localhost"};
        connection = factory.CreateConnection();
    }

    protected override Task ExecuteAsync(CancellationToken stoppingToken)
    {
        stoppingToken.ThrowIfCancellationRequested();

        foreach (var mqListener in listeners)
        {
            var channel = connection.CreateModel();
            channel.QueueDeclare(mqListener.RabbitMqQueueConfig);

            var consumer = new EventingBasicConsumer(channel);
            consumer.Received += (ch, ea) =>
            {
                var success = OnReceived(mqListener, ch, ea);
                if (success)
                    channel.BasicAck(ea.DeliveryTag, false);
                else
                    channel.BasicNack(ea.DeliveryTag, false, true); // TODO будет бесконечно спамиться, нужно ограничить попытки, делается с помощью заголовков
            };

            channel.BasicConsume(mqListener.RabbitMqQueueConfig.QueueName, false, consumer);
            channelsToDispose.Add(channel);
        }

        return Task.CompletedTask;
    }

    private static bool OnReceived(BaseRabbitMqListener listener, object? channel, BasicDeliverEventArgs args)
    {
        try
        {
            var content = Encoding.UTF8.GetString(args.Body.ToArray());

            object? message;
            if (listener.MessageType == typeof(string))
                message = content;
            else
                message = JsonConvert.DeserializeObject(content, listener.MessageType);

            if (message is null)
                throw new ArgumentException($"Can't deserialize message to type: {listener.MessageType}");

            listener.Handle(message);
            return true;
        }
        catch (Exception)
        {
            Console.WriteLine($"Error during execution message from {listener.RabbitMqQueueConfig.QueueName}");
            return false;
        }
    }

    public override void Dispose()
    {
        foreach (var channel in channelsToDispose)
            channel.Dispose();

        connection.Close();
        base.Dispose();
    }
}