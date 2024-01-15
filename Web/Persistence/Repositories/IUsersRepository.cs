using Domain.Entities;

namespace Web.Persistence.Repositories;

public interface IUsersRepository
{
    Task<User?> Get(Guid id);
    Task<User?> Get(string name);
    
    Task<List<string>> Find(string username);
}