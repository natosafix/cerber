using Domain.Infrastructure;

namespace Web.Services;

public interface IMailService
{
    Task SendWithImageAttachments(
        string username, 
        string email, 
        string subject, 
        string text, 
        IEnumerable<ImageInfo> imageInfos);
}