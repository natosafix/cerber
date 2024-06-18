namespace RabbitMqListener.Listeners.TicketSender.TicketViewModel;

public class HtmlTicketViewModel : ITicketViewModel
{
    public static HtmlTicketViewModel CreateFromMessage(
        TicketDestinationMessage message,
        string stylePath,
        string qrBase64,
        string coverPath) =>
        new(message.QrCodeSize, message.QrCodeX, message.QrCodeY, stylePath, qrBase64, coverPath);

    public HtmlTicketViewModel(
        int qrCodeSize,
        int qrCodeX,
        int qrCodeY,
        string stylesPath,
        string qrBase64,
        string coverPath)
    {
        QrCodeSize = qrCodeSize;
        QrCodeX = qrCodeX;
        QrCodeY = qrCodeY;
        StylesPath = stylesPath;
        QrBase64 = qrBase64;
        CoverPath = coverPath;
    }

    public int QrCodeSize { get; }
    public int QrCodeX { get; }
    public int QrCodeY { get; }
    public string StylesPath { get; }
    public string QrBase64 { get; }
    public string CoverPath { get; }
}