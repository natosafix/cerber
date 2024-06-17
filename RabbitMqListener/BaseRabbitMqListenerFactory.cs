using RabbitMQListener.Config;
using RabbitMQListener.Extensions;
using RabbitMqListener.Listeners;

namespace RabbitMQListener;

public abstract class BaseRabbitMqListenerFactory
{
    protected BaseRabbitMqListenerFactory(string queueName)
    {
        QueueName = queueName;
    }

    public string QueueName { get; }
    
    public abstract BaseRabbitMqConsumer CreateConsumer();
    public abstract BaseRabbitMqProducer CreateProducer();
}

public abstract class BaseRabbitMqListenerFactory<TMessage> : BaseRabbitMqListenerFactory
    where TMessage : class
{
    protected BaseRabbitMqListenerFactory(IRabbitMqConnectionsPool connectionsPool, string queueName) : base(queueName)
    {
        using var channel = connectionsPool.Get().CreateModel();
        channel.QueueDeclare(RabbitMqQueueConfig.CreateDefault(queueName));
    }

    public override BaseRabbitMqConsumer CreateConsumer() => CreateTConsumer();
    public override BaseRabbitMqProducer CreateProducer() => CreateTProducer();

    protected abstract BaseRabbitMqConsumer<TMessage> CreateTConsumer();
    protected abstract BaseRabbitMqProducer<TMessage> CreateTProducer();
}