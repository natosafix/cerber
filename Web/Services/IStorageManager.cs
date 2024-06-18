using Domain.Entities;

namespace Web.Services;

public interface IStorageManager
{
    Task<byte[]> Get(UserFile userFile);
    Task Save(IFormFile file, UserFile userFile);
    Task Remove(UserFile userFile);
}