namespace RabbitMqListener.Listeners.TicketSender.TicketViewModel;

public class BaseTicketViewModel
{
    public BaseTicketViewModel(string userName)
    {
        UserName = userName;
    }

    public string UserName { get; }
}