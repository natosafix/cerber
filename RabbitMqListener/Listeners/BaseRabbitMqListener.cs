using System;
using System.Threading.Tasks;
using RabbitMQListener.Config;

namespace RabbitMqListener.Listeners;

public abstract class BaseRabbitMqListener
{
    protected BaseRabbitMqListener(Type messageType)
    {
        MessageType = messageType;
    }

    public Type MessageType { get; }

    public abstract Task Handle(object? message);
    public abstract RabbitMqQueueConfig RabbitMqQueueConfig { get; }
}

public abstract class BaseRabbitMqListener<TMessage> : BaseRabbitMqListener
    where TMessage : class
{
    protected BaseRabbitMqListener() : base(typeof(TMessage))
    {
    }

    public override async Task Handle(object? message)
    {
        if (message is not TMessage parsed)
            throw new ArgumentNullException(nameof(message));

        await Handle(parsed);
    }

    protected abstract Task Handle(TMessage message);
}