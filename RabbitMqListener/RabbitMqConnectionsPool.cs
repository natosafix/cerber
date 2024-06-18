using System;
using RabbitMQ.Client;

namespace RabbitMQListener;

public interface IRabbitMqConnectionsPool : IDisposable
{
    IConnection Get();
}

public class RabbitMqConnectionsPool : IRabbitMqConnectionsPool
{
    private readonly Lazy<IConnection> connection;

    public RabbitMqConnectionsPool(string host = "localhost")
    {
        var factory = new ConnectionFactory {HostName = host};
        connection = new Lazy<IConnection>(() => factory.CreateConnection());
    }

    public IConnection Get()
    {
        return connection.Value;
    }

    public void Dispose()
    {
        if (connection.IsValueCreated)
            connection.Value.Dispose();
    }
}