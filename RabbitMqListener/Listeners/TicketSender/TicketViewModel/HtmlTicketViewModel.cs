using System;

namespace RabbitMqListener.Listeners.TicketSender.TicketViewModel;

public class HtmlTicketViewModel : ITicketViewModel
{
    public static HtmlTicketViewModel CreateFromMessage(
        TicketDestinationMessage message,
        string stylePath,
        string qrBase64,
        string coverImageBase64) =>
        new(message.QrCodeSize, message.QrCodeX, message.QrCodeY, stylePath, qrBase64, coverImageBase64);

    public HtmlTicketViewModel(
        int qrCodeSize,
        int qrCodeX,
        int qrCodeY,
        string stylesPath,
        string qrBase64,
        string coverImageBase64)
    {
        QrCodeSize = qrCodeSize;
        QrCodeX = qrCodeX;
        QrCodeY = qrCodeY;
        StylesPath = stylesPath;
        QrBase64 = qrBase64;
        CoverImageBase64 = coverImageBase64;
    }

    public int QrCodeSize { get; }
    public int QrCodeX { get; }
    public int QrCodeY { get; }
    public string StylesPath { get; }
    public string QrBase64 { get; }
    public string CoverImageBase64 { get; }
}