using Domain.Entities;

namespace Web.Services;

public interface IUserFilesService
{
    Task<UserFile> Get(Guid id);

    Task<UserFile?> TryGet(Guid id);

    Task<byte[]> GetContent(UserFile userFile);

    Task<UserFile> Save(IFormFile formFile, bool generateName = false);

    Task<IReadOnlyCollection<UserFile>> Save(IReadOnlyCollection<IFormFile> formFile, bool generateName = false);

    Task Remove(UserFile userFile);

    Task Remove(Guid userFileId);
}