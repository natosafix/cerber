using Domain.Entities;
using Microsoft.EntityFrameworkCore;

namespace Web.Persistence.Repositories;

public class UserRepository : IUserRepository
{
    private readonly CerberDbContext dbContext;
    
    public UserRepository(CerberDbContext dbContext)
    {
        this.dbContext = dbContext;
    }

    public async Task<User?> Get(string username)
    {
        return await dbContext.Users
            .Include(u => u.InspectedEvents)
            .FirstOrDefaultAsync(u => string.Equals(u.UserName, username));
    }
}