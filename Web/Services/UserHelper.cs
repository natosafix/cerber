using System.Security.Claims;
using Domain.Entities;
using Microsoft.AspNetCore.Identity;
using Web.Persistence.Repositories;

namespace Web.Services;

public class UserHelper : IUserHelper
{
    private readonly IHttpContextAccessor httpContextAccessor;
    private readonly UserManager<User> userManager;

    public UserHelper(IUsersRepository usersRepository, IHttpContextAccessor httpContextAccessor, UserManager<User> userManager)
    {
        this.httpContextAccessor = httpContextAccessor;
        this.userManager = userManager;
    }

    public string UserId => httpContextAccessor.HttpContext?.User.FindFirstValue(ClaimTypes.NameIdentifier) ??
                            throw new InvalidOperationException("User is not authenticated");
    
    public string Username => httpContextAccessor.HttpContext?.User.Identity?.Name ?? 
                              throw new InvalidOperationException("User is not authenticated");

    public async Task<User?> GetUser()
    {
        return await userManager.FindByIdAsync(UserId);
    }
}