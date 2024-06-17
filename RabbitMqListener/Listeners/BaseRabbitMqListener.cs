using System;
using RabbitMQListener.Config;

namespace RabbitMqListener.Listeners;

public abstract class BaseRabbitMqListener
{
    protected BaseRabbitMqListener(Type messageType)
    {
        MessageType = messageType;
    }

    public Type MessageType { get; }
    public abstract RabbitMqQueueConfig RabbitMqQueueConfig { get; }
    public abstract void Handle(object? message);
}

public abstract class BaseRabbitMqListener<TMessage> : BaseRabbitMqListener
    where TMessage : class
{
    protected BaseRabbitMqListener() : base(typeof(TMessage))
    {
    }

    public override void Handle(object? message)
    {
        if (message is not TMessage parsed)
            throw new ArgumentNullException(nameof(message));

        Handle(parsed);
    }

    protected abstract void Handle(TMessage message);
}