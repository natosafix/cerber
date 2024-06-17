using System;
using JetBrains.Annotations;

namespace RabbitMqListener.Listeners.TicketSender;

[PublicAPI]
public class TicketDestinationMessage
{
    public TicketDestinationMessage(string? email, string? qrEncrypted, int? qrCodeSize, int? qrCodeX, int? qrCodeY)
    {
        Email = email ?? throw new ArgumentNullException(nameof(email));
        QrEncrypted = qrEncrypted ?? throw new ArgumentNullException(nameof(qrEncrypted));
        QrCodeSize = qrCodeSize ?? throw new ArgumentNullException(nameof(qrCodeSize));
        QrCodeX = qrCodeX ?? throw new ArgumentNullException(nameof(qrCodeX));
        QrCodeY = qrCodeY ?? throw new ArgumentNullException(nameof(qrCodeY));
    }

    public string Email { get; }
    public string QrEncrypted { get; }
    public int QrCodeSize { get; }
    public int QrCodeX { get; }
    public int QrCodeY { get; }
}