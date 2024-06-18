using Microsoft.Extensions.Configuration;
using RabbitMQListener.Config;
using RabbitMQListener.Extensions;
using RabbitMqListener.Listeners;

namespace RabbitMQListener;

public abstract class BaseRabbitMqListenerFactory
{
    protected readonly IConfiguration Configuration;

    protected BaseRabbitMqListenerFactory(string queueName, IConfiguration configuration)
    {
        Configuration = configuration;
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

    protected BaseRabbitMqListenerFactory(IRabbitMqConnectionsPool connectionsPool, IConfiguration configuration, string queueName)
        : base(queueName, configuration)
    {
        ConnectionsPool = connectionsPool;
    }

    public override BaseRabbitMqConsumer<TMessage> CreateConsumer()
    {
        QueueDeclare();
        return CreateTConsumer();
    }

    public override BaseRabbitMqProducer<TMessage> CreateProducer()
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
        queueDeclared = true;
    }

    protected abstract BaseRabbitMqConsumer<TMessage> CreateTConsumer();
    protected abstract BaseRabbitMqProducer<TMessage> CreateTProducer();
}