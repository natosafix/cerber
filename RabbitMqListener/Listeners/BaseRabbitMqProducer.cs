using RabbitMQ.Client;
using RabbitMQListener;

namespace RabbitMqListener.Listeners;

public abstract class BaseRabbitMqProducer
{
}

public abstract class BaseRabbitMqProducer<TMessage> : BaseRabbitMqProducer
{
    private readonly IRabbitMqConnectionsPool connectionsPool;
    private readonly string queue;

    protected BaseRabbitMqProducer(IRabbitMqConnectionsPool connectionsPool, string queue)
    {
        this.connectionsPool = connectionsPool;
        this.queue = queue;
    }

    public virtual void Send(TMessage message)
    {
        var body = HandleMessage(message);

        var connection = connectionsPool.Get();
        using var channel = connection.CreateModel();

        channel.BasicPublish(
            exchange: string.Empty,
            routingKey: queue,
            basicProperties: null,
            body: body);
    }

    protected abstract byte[] HandleMessage(TMessage message);
}