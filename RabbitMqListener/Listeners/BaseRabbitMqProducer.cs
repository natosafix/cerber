using RabbitMQ.Client;
using RabbitMQListener;

namespace RabbitMqListener.Listeners;

public abstract class BaseRabbitMqProducer
{
}

public abstract class BaseRabbitMqProducer<TMessage> : BaseRabbitMqProducer
{
    protected readonly IRabbitMqConnectionsPool connectionsPool;

    public void Send(TMessage message)
    {
        var body = SendInternal(message);

        var connection = connectionsPool.Get();
        using var channel = connection.CreateModel();

        channel.BasicPublish(
            exchange: string.Empty,
            routingKey: "TestQueue",
            basicProperties: null,
            body: body);
    }

    protected abstract byte[] SendInternal(TMessage message);
}