using Domain.Entities;

namespace Web.Persistence.Repositories;

public class UserFilesRepository : IUserFilesRepository
{
    private readonly CerberDbContext dbContext;
    
    public UserFilesRepository(CerberDbContext dbContext)
    {
        this.dbContext = dbContext;
    }

    public async Task<UserFile> Get(int id)
    {
        return await dbContext.UserFiles.FindAsync(id);
    }

    public async Task<UserFile> Save(UserFile userFile)
    {
        var result = await dbContext.UserFiles.AddAsync(userFile);
        await dbContext.SaveChangesAsync();
        return result.Entity;
    }
}