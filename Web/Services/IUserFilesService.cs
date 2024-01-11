using Domain.Entities;

namespace Web.Services;

public interface IUserFilesService
{
    Task<UserFile> Get(int id);

    Task<byte[]> GetContent(UserFile userFile);

    Task<Stream> GetContentStream(int id);

    Task<UserFile> Save(IFormFile formFile);
}