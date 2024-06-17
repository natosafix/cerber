using System;
using System.Threading.Tasks;
using RabbitMQListener.Config;

namespace RabbitMqListener.Listeners;

/// <summary>
/// Listener for test
/// </summary>
public class HelloWorldConsumer : BaseRabbitMqConsumer<string>
{
    protected override Task Handle(string message)
    {
        Console.WriteLine(message);

        return Task.CompletedTask;
    }
}