namespace RabbitMqListener.Listeners.TicketSender.TicketViewModel;

public class HtmlTicketViewModel : BaseTicketViewModel
{
    public HtmlTicketViewModel(string userName, string stylesPath) : base(userName)
    {
        StylesPath = stylesPath;
    }
    
    public string StylesPath { get; }
}