using MimeKit;

namespace Domain.Infrastructure.Extenstions;

public static class ImageInfoExtensions
{
    public static MimePart ToAttachment(this ImageInfo imageInfo)
    {
        using var memoryStream = new MemoryStream(imageInfo.Content);
        return new MimePart("image", "png")
        {
            Content = new MimeContent(memoryStream),
            ContentDisposition = new ContentDisposition(ContentDisposition.Attachment),
            ContentTransferEncoding = ContentEncoding.Base64,
            FileName = imageInfo.FileName
        };
    }
}