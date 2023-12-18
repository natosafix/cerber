using Domain.Infrastructure;
using Domain.Infrastructure.Extenstions;
using MailKit.Net.Smtp;
using MimeKit;
using Web.Settings;

namespace Web.Services;

public class MailService : IMailService
{
    public const string FromName = "Cerber";
    private readonly EmailCredentials credentials;
    
    public MailService(IConfiguration configuration)
    {
        credentials = configuration.GetSection("EmailCredentials").Get<EmailCredentials>();
    }

    public async Task SendWithImageAttachments(
        string username, 
        string email, 
        string subject, 
        string text, 
        IEnumerable<ImageInfo> imageInfos)
    {
        var message = new MimeMessage();
        message.From.Add(new MailboxAddress(FromName, credentials.Email));
        message.To.Add(new MailboxAddress(username, email));
        message.Subject = subject;

        var multipart = new Multipart("mixed");
        
        var body = new TextPart
        {
            Text = text
        };
        multipart.Add(body);

        foreach (var qrCode in imageInfos)
        {
            multipart.Add(qrCode.ToAttachment());
        }
        
        message.Body = multipart;
        
        using (var client = new SmtpClient())
        {
            await client.ConnectAsync(host: "smtp.yandex.ru", port: 465, useSsl: true);
            await client.AuthenticateAsync(userName: credentials.Email, password: credentials.Password);
            await client.SendAsync(message);
            await client.DisconnectAsync(quit: true);
        }
    }
}