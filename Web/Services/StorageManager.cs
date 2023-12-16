namespace Web.Services;

public class StorageManager : IStorageManager
{
    private readonly IWebHostEnvironment webHostEnvironment;
    
    public StorageManager(IWebHostEnvironment webHostEnvironment)
    {
        this.webHostEnvironment = webHostEnvironment;
    }

    public async Task<byte[]> Get(string path)
    {
        return await File.ReadAllBytesAsync(webHostEnvironment.WebRootPath + path);
    }

    public async Task Save(IFormFile file, string path)
    {
        var webPath = webHostEnvironment.WebRootPath + path;
        var directory = Path.GetDirectoryName(webPath);
        
        if (!Directory.Exists(directory))
            Directory.CreateDirectory(directory);
        
        await using (var fileStream = new FileStream(webPath, FileMode.Create))
        {
            await file.CopyToAsync(fileStream);
        }
    }
}