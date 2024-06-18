using Domain.Entities;
using Domain.Infrastructure;

namespace Web.Services;

public interface IEventsService
{
    Task<Event> Get(int id);

    Task<Event> GetByTicketId(int ticketId);

    Task<Event> GetWithInspectors(int id);
    
    Task<Event> Create(Event @event);
    
    Task<List<string>> GetInspectors(int id);

    Task DeleteInspector(int id, string username);
    
    Task AddInspector(int id, Guid inspector);
    
    Task AddInspectorByUsername(int id, string username);
    
    Task<PageList<Event>> GetInspected(string username, int offset, int limit);
    
    Task<PageList<Event>> GetOwned(string username, int offset, int limit);
    
    Task<PageList<Event>> GetIncoming(int offset, int limit);
    
    Task<EventStats> GetStats(int id);
}