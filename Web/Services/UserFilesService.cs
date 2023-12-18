using Domain.Entities;
using Web.Persistence.Repositories;

namespace Web.Services;

public class UserFilesService : IUserFilesService
{
    public const string DefaultPath = "/Files";
    
    private readonly IUserFilesRepository userFilesRepository;
    private readonly IStorageManager storageManager;
    private readonly IUserHelper userHelper;

    public UserFilesService(IUserFilesRepository userFilesRepository, IStorageManager storageManager, IUserHelper userHelper)
    {
        this.userFilesRepository = userFilesRepository;
        this.storageManager = storageManager;
        this.userHelper = userHelper;
    }

    public async Task<UserFile> Get(int id)
    {
        return await userFilesRepository.Get(id) ?? throw new BadHttpRequestException($"Not found file with id {id}");
    }

    public async Task<byte[]> GetContent(UserFile userFile)
    {
        return await storageManager.Get(userFile.Path);
    }

    public async Task<UserFile> Save(IFormFile formFile)
    {
        var username = userHelper.Username;
        var userFile = new UserFile
        {
            Name = formFile.FileName,
            Path = $"{DefaultPath}/{username}/{formFile.FileName}"
        };
        await storageManager.Save(formFile, userFile.Path);
        return await userFilesRepository.Save(userFile);
    }
}