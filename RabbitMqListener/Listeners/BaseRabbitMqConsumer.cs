using System;
using System.Threading.Tasks;

namespace RabbitMqListener.Listeners;

public abstract class BaseRabbitMqConsumer
{
    protected BaseRabbitMqConsumer(Type messageType)
    {
        MessageType = messageType;
    }

    public Type MessageType { get; }

    public abstract Task Handle(object? message);
}

public abstract class BaseRabbitMqConsumer<TMessage> : BaseRabbitMqConsumer
    where TMessage : class
{
    protected BaseRabbitMqConsumer() : base(typeof(TMessage))
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