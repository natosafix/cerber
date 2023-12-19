namespace Web.Services;

public class AuthService : IAuthService
{
    private readonly IUserHelper userHelper;
    private readonly IEventsService eventsService;

    public AuthService(IUserHelper userHelper, IEventsService eventsService)
    {
        this.userHelper = userHelper;
        this.eventsService = eventsService;
    }
    
    public async Task<bool> IsOwner(string userId, int eventId)
    {
        var @event = await eventsService.Get(eventId);
            
        return @event.OwnerId == userId;
    }

    public async Task<bool> IsInspector(string userId, int eventId)
    {
        var @event = await eventsService.GetWithInspectors(eventId);
            
        return @event.OwnerId == userId || @event.Inspectors.Select(i => i.Id).Contains(userId);
    }
}