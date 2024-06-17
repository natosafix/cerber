namespace RabbitMqListener.Listeners.TicketSender;

public class TicketTemplateModel
{
    public TicketTemplateModel(string userName, string stylesPath)
    {
        UserName = userName;
        StylesPath = stylesPath;
    }

    public string UserName { get; }
    public string StylesPath { get; }
}