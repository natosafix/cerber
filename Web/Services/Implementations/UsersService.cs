using Web.Persistence.Repositories;

namespace Web.Services.Implementations;

public class UsersService : IUsersService
{
    private readonly IUsersRepository usersRepository;
    
    public UsersService(IUsersRepository usersRepository)
    {
        this.usersRepository = usersRepository;
    }

    public Task<List<string>> Find(string username)
    {
        return usersRepository.Find(username);
    }
}