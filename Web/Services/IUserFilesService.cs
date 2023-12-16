using Domain.Entities;

namespace Web.Services;

public interface IUserFilesService
{
    Task<UserFile> Get(int id);
    
    Task<byte[]> GetContent(UserFile userFile);
    
    Task<UserFile> Save(IFormFile formFile);
}