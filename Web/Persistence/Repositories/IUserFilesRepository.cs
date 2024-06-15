using Domain.Entities;

namespace Web.Persistence.Repositories;

public interface IUserFilesRepository
{
    Task<UserFile?> Get(int id);

    Task<UserFile> Save(UserFile userFile);

    Task Remove(UserFile userFile);

    Task Remove(int userFileId);
}