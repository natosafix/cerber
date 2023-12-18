using Domain.Entities;

namespace Web.Services;

public interface IUserHelper
{
    string Username { get; }

    Task<User?> GetUser();
}