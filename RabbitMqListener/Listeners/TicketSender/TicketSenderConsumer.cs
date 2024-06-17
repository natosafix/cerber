using System;
using System.IO;
using System.Threading.Tasks;
using Microsoft.Extensions.Configuration;
using Minio;
using Minio.DataModel.Args;
using QRCoder;
using RabbitMqListener.Listeners.TicketSender.TicketViewGenerator;
using RabbitMqListener.Listeners.TicketSender.TicketViewModel;
using RabbitMQListener.StaticFiles;

namespace RabbitMqListener.Listeners.TicketSender;

public class TicketSenderConsumer : BaseRabbitMqConsumer<TicketDestinationMessage>
{
    private static readonly ITicketViewGenerator<HtmlTicketViewModel> ticketViewGenerator =
        WkHtmlToPdfTicketGenerator.WithDefaultSettings(
            File.ReadAllText(Path.Combine(StaticFiles.BaseDirectory, TemplateFileName)));

    private const string TemplateFileName = "TicketTemplate.cshtml";
    
    private readonly EmailSender.EmailSender emailSender;
    private readonly QRCodeGenerator qrGenerator = new();
    private readonly IMinioClient minio;

    public TicketSenderConsumer(IConfiguration configuration)
    {
        minio = new MinioClient()
            .WithEndpoint("s3.yandexcloud.net")
            .WithRegion("ru-central1")
            .WithCredentials(configuration["CloudStorageOptions:AccessKey"], configuration["CloudStorageOptions:SecretKey"])
            .WithSSL(false)
            .Build();
        emailSender = new EmailSender.EmailSender(configuration);
    }

    protected override Task Handle(TicketDestinationMessage message)
    {
        var stylesPath = new FileInfo(Path.Combine(StaticFiles.BaseDirectory, $"{TemplateFileName}.css"));
        
        var qrBase64 = GetQrBase64(message.QrEncrypted);
        var coverBase64 = GetCoverBase64(message.CoverImageId.ToString());
        
        var viewModel = HtmlTicketViewModel.CreateFromMessage(message, stylesPath.FullName, qrBase64, coverBase64);
        
        var pdf = ticketViewGenerator.Generate(viewModel);
        
        emailSender.SendWithImageAttachments(
            "", message.Email, "Ticket", "Спасибо за заказ. Ваши билеты во вложениях", pdf, "Ticket.pdf")
            .GetAwaiter()
            .GetResult();

        return Task.CompletedTask;
    }

    private string GetQrBase64(string qrEncrypted)
    {
        using var qrCodeData = qrGenerator.CreateQrCode(qrEncrypted, QRCodeGenerator.ECCLevel.Q);
        var qrCode = new BitmapByteQRCode(qrCodeData);
        var qrBase64 = Convert.ToBase64String(qrCode.GetGraphic(3));
        return qrBase64;
    }

    private string GetCoverBase64(string imageId)
    {
        using var bytesStream = new MemoryStream();
        var goArgs = new GetObjectArgs()
            .WithBucket("cerber")
            .WithObject(imageId)
            .WithCallbackStream(stream => stream.CopyTo(bytesStream));
        minio.GetObjectAsync(goArgs).GetAwaiter().GetResult();
        var bytes = bytesStream.ToArray();
        var coverBase64 = Convert.ToBase64String(bytes);
        return coverBase64;
    }
}