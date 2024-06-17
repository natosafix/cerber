using RabbitMqListener.Listeners.TicketSender.TicketViewModel;

namespace RabbitMqListener.Listeners.TicketSender.TicketViewGenerator;

public interface ITicketViewGenerator<in TModel> where TModel : ITicketViewModel
{
    byte[] Generate(TModel model);
}