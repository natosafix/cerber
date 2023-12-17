using MailKit.Net.Smtp;
using MimeKit;
using Web.Settings;

namespace Web.Services;

public class MailService : IMailService
{
    private readonly EmailCredentials credentials;
    
    public MailService(IConfiguration configuration)
    {
        credentials = configuration.GetSection("EmailCredentials").Get<EmailCredentials>();
    }

    public async Task Send(string username, string email, object data)
    {
        var message = new MimeMessage();
        message.From.Add(new MailboxAddress("Cerber", credentials.Email));
        message.To.Add(new MailboxAddress(username, email));
        message.Subject = "Tickets";

        message.Body = new TextPart()
        {
            Text = "Qr here"
        };
        
        using (var client = new SmtpClient())
        {
            await client.ConnectAsync(host: "smtp.yandex.ru", port: 465, useSsl: true);
            await client.AuthenticateAsync(userName: credentials.Email, password: credentials.Password);
            await client.SendAsync(message);
            await client.DisconnectAsync(quit: true);
        }
    }
}