using Newtonsoft.Json;
using RabbitMQListener;

namespace RabbitMqListener.Listeners.TicketSender;

public class TicketSenderProducer : BaseRabbitMqProducer<TicketDestinationMessage>
{
    internal TicketSenderProducer(IRabbitMqConnectionsPool connectionsPool, string queue)
        : base(connectionsPool, queue)
    {
    }

    protected override byte[] HandleMessage(TicketDestinationMessage message)
    {
        var messageSerialized = JsonConvert.SerializeObject(message);
        var body = System.Text.Encoding.UTF8.GetBytes(messageSerialized);
        return body;
    }
}