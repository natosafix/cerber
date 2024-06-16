using System;
using System.Diagnostics;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.Extensions.Hosting;
using RabbitMQ.Client;
using RabbitMQ.Client.Events;

namespace RabbitMQListener;

public class RabbitMqListenerService : BackgroundService
{
    private readonly IConnection connection;
    private readonly IModel channel;

    public RabbitMqListenerService()
    {
        var factory = new ConnectionFactory { HostName = "localhost" };
        connection = factory.CreateConnection();
        channel = connection.CreateModel();
        channel.QueueDeclare(queue: "TestQueue", durable: true, exclusive: false, autoDelete: false, arguments: null);
    }

    
    protected override Task ExecuteAsync(CancellationToken stoppingToken)
    {
        stoppingToken.ThrowIfCancellationRequested();

        var consumer = new EventingBasicConsumer(channel);
        consumer.Received += (ch, ea) =>
        {
            var content = Encoding.UTF8.GetString(ea.Body.ToArray());
            
            // Каким-то образом обрабатываем полученное сообщение
            Console.WriteLine($"Получено сообщение: {content}");

            channel.BasicAck(ea.DeliveryTag, false);
        };

        channel.BasicConsume("TestQueue", false, consumer);

        return Task.CompletedTask;
    }
    
    public override void Dispose()
    {
        channel.Close();
        connection.Close();
        base.Dispose();
    }
}