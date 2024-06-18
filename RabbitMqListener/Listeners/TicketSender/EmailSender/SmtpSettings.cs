namespace RabbitMqListener.Listeners.TicketSender.EmailSender;

public class SmtpSettings
{
    public string Email { get; set; }
    
    public string Password { get; set; }
    
    public string Server { get; set; }
    
    public int ServerPort { get; set; }
}