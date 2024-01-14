namespace Web.Services.Implementations;

public class StorageManager : IStorageManager
{
    private readonly IWebHostEnvironment webHostEnvironment;
    
    public StorageManager(IWebHostEnvironment webHostEnvironment)
    {
        this.webHostEnvironment = webHostEnvironment;
    }

    public async Task<byte[]> Get(string path)
    {
        var a = Path.Combine(webHostEnvironment.WebRootPath, path);
        return await File.ReadAllBytesAsync(Path.Combine(webHostEnvironment.WebRootPath, path));
    }

    public Stream GetFileStream(string path)
    {
        var webPath = Path.Combine(webHostEnvironment.WebRootPath, path);
        var stream = new FileStream(webPath, FileMode.Open, FileAccess.Read, FileShare.Read);
        return stream;
    }

    public async Task Save(IFormFile file, string path)
    {
        var webPath = Path.Combine(webHostEnvironment.WebRootPath, path);
        var directory = new DirectoryInfo(webPath).Parent!;
        
        if (!directory.Exists)
            directory.Create();

        await using var fileStream = new FileStream(webPath, FileMode.Create);
        await file.CopyToAsync(fileStream);
    }

    public void Remove(string path)
    {
        var webPath = Path.Combine(webHostEnvironment.WebRootPath, path);
        File.Delete(webPath);
    }
}