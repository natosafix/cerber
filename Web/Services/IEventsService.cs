using Domain.Entities;
using Domain.Infrastructure;

namespace Web.Services;

public interface IEventsService
{
    Task<Event> Get(int id);
    
    Task<Event> Create(Event @event);
    
    Task AddInspector(int id, Guid inspector);
    
    Task<PageList<Event>> GetInspected(string username, int offset, int limit);
    
    Task<PageList<Event>> GetOwned(string username, int offset, int limit);
}