using RabbitMQ.Client;
using RabbitMQListener.Config;

namespace RabbitMQListener.Extensions;

public static class RabbitMqModelExtensions
{
    public static QueueDeclareOk QueueDeclare(this IModel channel, RabbitMqQueueConfig cfg)
    {
        return channel.QueueDeclare(
            cfg.QueueName,
            cfg.Durable,
            cfg.Exclusive,
            cfg.AutoDelete,
            cfg.Arguments);
    }
}