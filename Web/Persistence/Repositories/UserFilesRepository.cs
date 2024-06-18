using Domain.Entities;
using Microsoft.EntityFrameworkCore;

namespace Web.Persistence.Repositories;

public class UserFilesRepository : IUserFilesRepository
{
    private readonly CerberDbContext dbContext;

    public UserFilesRepository(CerberDbContext dbContext)
    {
        this.dbContext = dbContext;
    }

    public async Task<UserFile?> Get(Guid id)
    {
        return await dbContext.UserFiles.FindAsync(id);
    }

    public async Task<UserFile> Save(UserFile userFile)
    {
        var result = await dbContext.UserFiles.AddAsync(userFile);
        await dbContext.SaveChangesAsync();
        return result.Entity;
    }

    public async Task Remove(UserFile userFile)
    {
        await dbContext.UserFiles.Where(uf => uf.Id == userFile.Id).ExecuteDeleteAsync();
        await dbContext.SaveChangesAsync();
    }

    public async Task Remove(Guid userFileId)
    {
        await dbContext.UserFiles.Where(uf => uf.Id == userFileId).ExecuteDeleteAsync();
        await dbContext.SaveChangesAsync();
    }
}