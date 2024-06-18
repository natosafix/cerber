using Domain.Entities;

namespace Web.Services.Implementations;

public class LocalStorageManager : IStorageManager
{
    private readonly IWebHostEnvironment webHostEnvironment;
    
    public LocalStorageManager(IWebHostEnvironment webHostEnvironment)
    {
        this.webHostEnvironment = webHostEnvironment;
    }

    public async Task<byte[]> Get(UserFile userFile)
    {
        return await File.ReadAllBytesAsync(Path.Combine(webHostEnvironment.WebRootPath, userFile.Path));
    }

    public async Task Save(IFormFile file, UserFile userFile)
    {
        var webPath = Path.Combine(webHostEnvironment.WebRootPath, userFile.Path);
        var directory = new DirectoryInfo(webPath).Parent!;
        
        if (!directory.Exists)
            directory.Create();

        await using var fileStream = new FileStream(webPath, FileMode.Create);
        await file.CopyToAsync(fileStream);
    }

    public Task Remove(UserFile userFile)
    {
        var webPath = Path.Combine(webHostEnvironment.WebRootPath, userFile.Path);
        File.Delete(webPath);
        return Task.CompletedTask;
    }
}