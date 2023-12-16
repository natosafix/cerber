using Domain.Entities;

namespace Web.Services;

public interface IUserHelper
{
    string UserId { get; }

    Task<User?> GetUser();
}