namespace Web.Services;

public interface IAuthService
{
    Task<bool> IsOwner(string userId, int eventId);
    
    Task<bool> IsInspector(string userId, int eventId);
}