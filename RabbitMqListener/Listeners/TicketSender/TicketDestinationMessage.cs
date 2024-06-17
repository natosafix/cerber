using JetBrains.Annotations;

namespace RabbitMqListener.Listeners.TicketSender;

[PublicAPI]
public class TicketDestinationMessage
{
    public TicketDestinationMessage(string qrCodeSize, string qrCodeX, string qrCodeY)
    {
        QrCodeSize = qrCodeSize;
        QrCodeX = qrCodeX;
        QrCodeY = qrCodeY;
    }

    public string QrCodeSize { get; }
    public string QrCodeX { get; }
    public string QrCodeY { get; }
}