using System;
using System.Threading.Tasks;
using RabbitMQListener.Config;

namespace RabbitMqListener.Listeners;

/// <summary>
/// Listener for test
/// </summary>
public class HelloWorldListener : BaseRabbitMqListener<string>
{
    protected override Task Handle(string message)
    {
        Console.WriteLine(message);

        return Task.CompletedTask;
    }

    public override RabbitMqQueueConfig RabbitMqQueueConfig => RabbitMqQueueConfig.CreateDefault("TestQueue");
}