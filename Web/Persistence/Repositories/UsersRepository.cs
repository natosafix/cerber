using Domain.Entities;
using Microsoft.EntityFrameworkCore;

namespace Web.Persistence.Repositories;

public class UsersRepository : IUsersRepository
{
    private readonly CerberDbContext dbContext;
    
    public UsersRepository(CerberDbContext dbContext)
    {
        this.dbContext = dbContext;
    }

    public async Task<User?> Get(Guid id)
    {
        return await dbContext.Users
            .FindAsync(id.ToString());
    }
    
    public async Task<User?> Get(string username)
    {
        return await dbContext.Users
            .FirstOrDefaultAsync(u => string.Equals(u.UserName, username));
    }

    public async Task<List<string>> Find(string username)
    {
        return await dbContext.Users
            .Where(u => u.UserName.StartsWith(username))
            .Take(5)
            .Select(u => u.UserName)
            .ToListAsync();
    }
}