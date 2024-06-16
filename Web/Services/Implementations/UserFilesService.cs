using Domain.Entities;
using Web.Persistence.Repositories;

namespace Web.Services.Implementations;

public class UserFilesService : IUserFilesService
{
    private const string DefaultPath = "Files";

    private readonly IUserFilesRepository userFilesRepository;
    private readonly IStorageManager storageManager;
    private readonly IUserHelper userHelper;

    public UserFilesService(
        IUserFilesRepository userFilesRepository,
        IStorageManager storageManager,
        IUserHelper userHelper)
    {
        this.userFilesRepository = userFilesRepository;
        this.storageManager = storageManager;
        this.userHelper = userHelper;
    }

    public async Task<UserFile> Get(Guid id)
    {
        return await userFilesRepository.Get(id) ?? throw new BadHttpRequestException($"Not found file with id {id}");
    }

    public async Task<UserFile?> TryGet(Guid id)
    {
        return await userFilesRepository.Get(id);
    }

    public async Task<byte[]> GetContent(UserFile userFile)
    {
        return await storageManager.Get(userFile);
    }

    public async Task<UserFile> Save(IFormFile formFile, bool generateName = false)
    {
        var username = userHelper.Username;
        var fileName = generateName ? Guid.NewGuid().ToString() : formFile.FileName;
        var userFile = new UserFile
        {
            Id = Guid.NewGuid(),
            Name = fileName,
            Path = Path.Combine(DefaultPath, username, fileName)
        };
        await storageManager.Save(formFile, userFile);
        return await userFilesRepository.Save(userFile);
    }

    public async Task<IReadOnlyCollection<UserFile>> Save(
        IReadOnlyCollection<IFormFile> formFile,
        bool generateName = false)
    {
        var result = new List<UserFile>(formFile.Count);

        foreach (var file in formFile)
        {
            var userFile = await Save(file, generateName);
            result.Add(userFile);
        }

        return result;
    }

    public async Task Remove(UserFile userFile)
    {
        await userFilesRepository.Remove(userFile);
        storageManager.Remove(userFile);
    }

    public async Task Remove(Guid userFileId)
    {
        var userFile = await Get(userFileId);
        await userFilesRepository.Remove(userFileId);
        storageManager.Remove(userFile);
    }
}