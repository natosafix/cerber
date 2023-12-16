namespace Web.Services;

public interface IStorageManager
{
    Task<byte[]> Get(string path);
    
    Task Save(IFormFile file, string path);
}