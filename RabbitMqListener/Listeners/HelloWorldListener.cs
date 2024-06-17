using System;
using RabbitMQListener.Config;

namespace RabbitMqListener.Listeners;

/// <summary>
/// Listener for test
/// </summary>
public class HelloWorldListener : BaseRabbitMqListener<string>
{
    public override RabbitMqQueueConfig RabbitMqQueueConfig => RabbitMqQueueConfig.CreateDefault("TestQueue");

    protected override void Handle(string message)
    {
        Console.WriteLine(message);
    }
}