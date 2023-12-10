using Domain.Entities;

namespace Web.Persistence.Repositories;

public interface IUserRepository
{
    Task<User?> Get(string name);
}