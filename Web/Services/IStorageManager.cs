namespace Web.Services;

public interface IStorageManager
{
    Task<byte[]> Get(string path);
    Stream GetFileStream(string path);
    Task Save(IFormFile file, string path);
}