namespace RabbitMqListener.Listeners.TicketSender.TicketViewModel;

public class HtmlTicketViewModel : ITicketViewModel
{
    public static HtmlTicketViewModel CreateFromMessage(TicketDestinationMessage message, string stylePath) =>
        new(message.QrCodeSize, message.QrCodeX, message.QrCodeY, stylePath);
    
    public HtmlTicketViewModel(string qrCodeSize, string qrCodeX, string qrCodeY, string stylesPath)
    {
        QrCodeSize = qrCodeSize;
        QrCodeX = qrCodeX;
        QrCodeY = qrCodeY;
        StylesPath = stylesPath;
    }

    public string QrCodeSize { get; }
    public string QrCodeX { get; }
    public string QrCodeY { get; }
    public string StylesPath { get; }
}