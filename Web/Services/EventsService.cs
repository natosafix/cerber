using Domain.Entities;
using Web.Persistence.Repositories;

namespace Web.Services;

public class EventsService : IEventsService
{
    private readonly IUserRepository userRepository;
    private readonly IEventsRepository eventsRepository;

    public EventsService(IUserRepository userRepository, IEventsRepository eventsRepository)
    {
        this.userRepository = userRepository;
        this.eventsRepository = eventsRepository;
    }

    public async Task<Event> Create(Event @event)
    {
        return await eventsRepository.Create(@event);
    }

    public async Task<List<Event>> GetInspected(string username)
    {
        var user = await userRepository.Get(username);
        return user?.InspectedEvents ?? new List<Event>();
    }
}