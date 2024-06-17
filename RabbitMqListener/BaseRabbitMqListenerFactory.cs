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
    protected readonly IRabbitMqConnectionsPool ConnectionsPool;
    private bool queueDeclared;

    protected BaseRabbitMqListenerFactory(IRabbitMqConnectionsPool connectionsPool, string queueName) : base(queueName)
    {
        ConnectionsPool = connectionsPool;
    }

    public override BaseRabbitMqConsumer CreateConsumer()
    {
        QueueDeclare();
        return CreateTConsumer();
    }

    public override BaseRabbitMqProducer CreateProducer()
    {
        QueueDeclare();
        return CreateTProducer();
    }

    private void QueueDeclare()
    {
        if (queueDeclared)
            return;

        using var channel = ConnectionsPool.Get().CreateModel();
        channel.QueueDeclare(RabbitMqQueueConfig.CreateDefault(QueueName));
        queueDeclared = false;
    }

    protected abstract BaseRabbitMqConsumer<TMessage> CreateTConsumer();
    protected abstract BaseRabbitMqProducer<TMessage> CreateTProducer();
}