using Microsoft.Extensions.Configuration;
using RabbitMQListener;

namespace RabbitMqListener.Listeners.TicketSender;

public class TicketSenderListenerFactory : BaseRabbitMqListenerFactory<TicketDestinationMessage>
{
    public TicketSenderListenerFactory(IRabbitMqConnectionsPool connectionsPool, IConfiguration configuration, string queueName = "Tickets.Sender")
        : base(connectionsPool, configuration, queueName)
    {
    }

    protected override BaseRabbitMqConsumer<TicketDestinationMessage> CreateTConsumer()
        => new TicketSenderConsumer(Configuration);
    protected override BaseRabbitMqProducer<TicketDestinationMessage> CreateTProducer()
        => new TicketSenderProducer(ConnectionsPool, QueueName);
}