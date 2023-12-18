using Domain.Infrastructure;

namespace Web.Services;

public interface IQrCodeService
{
    ImageInfo Create(string name, string payload);
}