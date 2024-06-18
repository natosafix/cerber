using System.IO;
using System.Threading.Tasks;
using Microsoft.Extensions.Configuration;
using MimeKit;
using SmtpClient = MailKit.Net.Smtp.SmtpClient;

namespace RabbitMqListener.Listeners.TicketSender.EmailSender;

public class EmailSender
{
    private const string FromName = "Cerber";
    private readonly SmtpSettings settings;

    public EmailSender(IConfiguration configuration)
    {
        settings = configuration.GetSection("SmtpSettings").Get<SmtpSettings>();
    }

    public async Task SendWithImageAttachments(
        string username,
        string email,
        string subject,
        string text,
        byte[] pdf,
        string fileName)
    {
        var message = new MimeMessage();
        message.From.Add(new MailboxAddress(FromName, settings.Email));
        message.To.Add(new MailboxAddress(username, email));
        message.Subject = subject;

        var multipart = new Multipart("mixed");

        var body = new TextPart
        {
            Text = text
        };
        multipart.Add(body);

        var attachment = new MimePart("image", "pdf")
        {
            Content = new MimeContent(new MemoryStream(pdf)),
            ContentDisposition = new ContentDisposition(ContentDisposition.Attachment),
            ContentTransferEncoding = ContentEncoding.Base64,
            FileName = fileName
        };
        multipart.Add(attachment);

        message.Body = multipart;

        using (var client = new SmtpClient())
        {
            await client.ConnectAsync(host: settings.Server, port: settings.ServerPort, useSsl: true);
            await client.AuthenticateAsync(userName: settings.Email, password: settings.Password);
            await client.SendAsync(message);
            await client.DisconnectAsync(quit: true);
        }

        attachment.Content.Dispose();
        attachment.Dispose();
    }
}