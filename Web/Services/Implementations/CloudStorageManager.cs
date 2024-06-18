using Domain.Entities;
using Minio;
using Minio.DataModel.Args;

namespace Web.Services.Implementations;

public class CloudStorageManager : IStorageManager
{
    private readonly IMinioClient minio;

    private const string BucketName = "cerber";

    public CloudStorageManager(IMinioClient minio)
    {
        this.minio = minio;
        var beArgs = new BucketExistsArgs()
            .WithBucket(BucketName);
        var found = minio.BucketExistsAsync(beArgs).GetAwaiter().GetResult();
        if (!found)
        {
            var mbArgs = new MakeBucketArgs()
                .WithBucket(BucketName);
            minio.MakeBucketAsync(mbArgs).Wait();
        }
    }

    public async Task<byte[]> Get(UserFile userFile)
    {
        using var bytesStream = new MemoryStream();
        var goArgs = new GetObjectArgs()
            .WithBucket(BucketName)
            .WithObject(userFile.Id.ToString())
            .WithCallbackStream(stream => stream.CopyTo(bytesStream));
        await minio.GetObjectAsync(goArgs);
        return bytesStream.ToArray();
    }

    public async Task Save(IFormFile file, UserFile userFile)
    {
        var putObjectArgs = new PutObjectArgs()
            .WithBucket(BucketName)
            .WithObject(userFile.Id.ToString())
            .WithStreamData(file.OpenReadStream())
            .WithContentType(file.ContentType)
            .WithObjectSize(file.Length);
        await minio.PutObjectAsync(putObjectArgs).ConfigureAwait(false);
    }

    public async Task Remove(UserFile userFile)
    {
        var removeObjectArgs = new RemoveObjectArgs()
            .WithBucket(BucketName)
            .WithObject(userFile.Id.ToString());
        await minio.RemoveObjectAsync(removeObjectArgs);
    }
}