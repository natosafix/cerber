﻿using RabbitMQListener;

namespace RabbitMqListener.Listeners.TicketSender;

public class TicketSenderListenerFactory : BaseRabbitMqListenerFactory<TicketDestinationMessage>
{
    public TicketSenderListenerFactory(IRabbitMqConnectionsPool connectionsPool, string queueName = "Tickets.Sender")
        : base(connectionsPool, queueName)
    {
    }

    protected override BaseRabbitMqConsumer<TicketDestinationMessage> CreateTConsumer() => new TicketSenderConsumer();
    protected override BaseRabbitMqProducer<TicketDestinationMessage> CreateTProducer() => new TicketSenderProducer(ConnectionsPool, QueueName);
}