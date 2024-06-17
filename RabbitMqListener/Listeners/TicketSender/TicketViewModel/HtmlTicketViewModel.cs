namespace RabbitMqListener.Listeners.TicketSender.TicketViewModel;

public class HtmlTicketViewModel : ITicketViewModel
{
    public static HtmlTicketViewModel CreateFromMessage(TicketDestinationMessage message, string stylePath) =>
        new(message.Email, message.QrEncrypted, message.QrCodeSize, message.QrCodeX, message.QrCodeY, stylePath);

    public HtmlTicketViewModel(
        string email,
        string qrEncrypted,
        int qrCodeSize,
        int qrCodeX,
        int qrCodeY,
        string stylesPath)
    {
        Email = email;
        QrEncrypted = qrEncrypted;
        QrCodeSize = qrCodeSize;
        QrCodeX = qrCodeX;
        QrCodeY = qrCodeY;
        StylesPath = stylesPath;
    }

    public string Email { get; }
    public string QrEncrypted { get; }
    public int QrCodeSize { get; }
    public int QrCodeX { get; }
    public int QrCodeY { get; }
    public string StylesPath { get; }
}