using Domain.Infrastructure;
using QRCoder;

namespace Web.Services.Implementations;

public class QrCodeService : IQrCodeService
{
    private readonly QRCodeGenerator qrGenerator = new();

    public ImageInfo Create(string name, string payload)
    {
        var qrCodeData = qrGenerator.CreateQrCode(payload, QRCodeGenerator.ECCLevel.Q);
        var qrCode = new BitmapByteQRCode(qrCodeData);
        return new ImageInfo(name, qrCode.GetGraphic(20));
    }
}