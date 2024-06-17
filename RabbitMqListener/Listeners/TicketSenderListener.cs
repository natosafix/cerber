using RabbitMQListener.Config;

namespace RabbitMqListener.Listeners;

public class TicketSenderListener : BaseRabbitMqListener<string>
{
    public override RabbitMqQueueConfig RabbitMqQueueConfig => RabbitMqQueueConfig.CreateDefault("Tickets.Sender");

    protected override void Handle(string message)
    {
        throw new System.NotImplementedException();
    }
}