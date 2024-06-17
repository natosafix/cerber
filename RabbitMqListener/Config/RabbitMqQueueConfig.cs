using System.Collections.Generic;

namespace RabbitMQListener.Config;

public class RabbitMqQueueConfig
{
    public static RabbitMqQueueConfig CreateDefault(string queueName) => new(queueName, true, false, false, null);
    
    public RabbitMqQueueConfig(
        string queueName,
        bool durable,
        bool exclusive,
        bool autoDelete,
        IDictionary<string, object>? arguments)
    {
        QueueName = queueName;
        Durable = durable;
        Exclusive = exclusive;
        AutoDelete = autoDelete;
        Arguments = arguments;
    }

    public string QueueName { get; }
    public bool Durable { get; }
    public bool Exclusive { get; }
    public bool AutoDelete { get; }
    public IDictionary<string, object>? Arguments { get; }
}