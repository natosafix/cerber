using Domain.Entities;

namespace Web.Services;

public interface IUserHelper
{
    string UserId { get; }
    
    string Username { get; }

    Task<User?> GetUser();
}