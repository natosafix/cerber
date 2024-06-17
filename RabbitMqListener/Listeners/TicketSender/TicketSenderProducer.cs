using Newtonsoft.Json;
using RabbitMQ.Client;
using RabbitMQListener;

namespace RabbitMqListener.Listeners.TicketSender;

public class TicketSenderProducer : BaseRabbitMqProducer<TicketDestinationMessage>
{
    internal TicketSenderProducer()
    {
    }

    protected override byte[] SendInternal(TicketDestinationMessage message)
    {
        var messageSerialized = JsonConvert.SerializeObject(message);
        var body = System.Text.Encoding.UTF8.GetBytes(messageSerialized);
        return body;
    }
}