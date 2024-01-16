using MimeKit;

namespace Domain.Infrastructure.Extenstions;

public static class ImageInfoExtensions
{
    public static MimePart ToAttachment(this ImageInfo imageInfo)
    {
        return new MimePart("image", "png")
        {
            Content = new MimeContent(new MemoryStream(imageInfo.Content)),
            ContentDisposition = new ContentDisposition(ContentDisposition.Attachment),
            ContentTransferEncoding = ContentEncoding.Base64,
            FileName = imageInfo.FileName
        };
    }
}