namespace Web.Services;

public interface IUsersService
{
    Task<List<string>> Find(string username);
}