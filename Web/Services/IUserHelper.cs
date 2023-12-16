using Domain.Entities;

namespace Web.Services;

public interface IUserHelper
{
    string Username { get; }
    
    string UserId { get; }

    Task<User?> GetUser();
}