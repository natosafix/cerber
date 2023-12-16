using Domain.Entities;
using Web.Persistence.Repositories;

namespace Web.Services;

public class UserHelper : IUserHelper
{
    private readonly IUsersRepository usersRepository;
    private readonly IHttpContextAccessor httpContextAccessor;

    public UserHelper(IUsersRepository usersRepository, IHttpContextAccessor httpContextAccessor)
    {
        this.usersRepository = usersRepository;
        this.httpContextAccessor = httpContextAccessor;
    }

    public string Username => httpContextAccessor.HttpContext?.User?.Identity?.Name ?? 
                              throw new InvalidOperationException("User is not authenticated");
    
    public string UserId => throw new NotImplementedException(); // TODO наверное надо из Claim'ов доставать

    public async Task<User?> GetUser()
    {
        return await usersRepository.Get(Username);
    }
}