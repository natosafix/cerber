using RabbitMQListener;

namespace RabbitMqListener.Listeners;

public class StabRabbitMqProducer<TMessage> : BaseRabbitMqProducer<TMessage>
{
    public StabRabbitMqProducer(IRabbitMqConnectionsPool connectionsPool, string queue) : base(connectionsPool, queue)
    {
    }

    public override void Send(TMessage message)
    {
    }

    protected override byte[] HandleMessage(TMessage message)
    {
        throw new System.NotImplementedException();
    }
}