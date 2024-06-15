using Domain.Entities;

namespace Web.Services;

public interface IUserFilesService
{
    Task<UserFile> Get(int id);

    Task<UserFile?> TryGet(int id);

    Task<byte[]> GetContent(UserFile userFile);

    Stream GetContentStream(UserFile userFile);

    Task<UserFile> Save(IFormFile formFile, bool generateName = false);

    Task<IReadOnlyCollection<UserFile>> Save(IReadOnlyCollection<IFormFile> formFile, bool generateName = false);

    Task Remove(UserFile userFile);

    Task Remove(int userFileId);
}