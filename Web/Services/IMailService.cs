namespace Web.Services;

public interface IMailService
{
    Task Send(string username, string email, object data);
}