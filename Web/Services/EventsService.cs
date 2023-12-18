using Domain.Entities;
using Domain.Infrastructure;
using Web.Persistence.Repositories;

namespace Web.Services;

public class EventsService : IEventsService
{
    private readonly IUsersRepository usersRepository;
    private readonly IEventsRepository eventsRepository;

    public EventsService(IUsersRepository usersRepository, IEventsRepository eventsRepository)
    {
        this.usersRepository = usersRepository;
        this.eventsRepository = eventsRepository;
    }

    public async Task<Event> Get(int id)
    {
       return await eventsRepository.Get(id) ?? throw new BadHttpRequestException($"Not found event with id {id}");
    }

    public async Task<Event> Create(Event @event)
    {
        return await eventsRepository.Create(@event);
    }
    
    public async Task AddInspector(int id, Guid inspectorId)
    {
        var inspector = await usersRepository.Get(inspectorId) ?? throw new BadHttpRequestException($"Not found inspector with id {inspectorId}");
        var @event = await Get(id);
        await eventsRepository.AddInspector(@event, inspector);
    }

    public async Task<PageList<Event>> GetInspected(string username, int offset, int limit)
    {
        return await eventsRepository.GetInspected(username, offset, limit);
    }

    public async Task<PageList<Event>> GetOwned(string username, int offset, int limit)
    {
        return await eventsRepository.GetOwned(username, offset, limit);
    }
}