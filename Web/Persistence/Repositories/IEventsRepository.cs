using Domain.Entities;
using Web.Models;

namespace Web.Persistence.Repositories;

public interface IEventsRepository
{
    Task<Event> Create(Event @event);
    
    Task AddInspector(int id, User inspector);

    Task<PageList<Event>> GetInspected(string username, int offset, int limit);
    
    Task<PageList<Event>> GetOwned(string username, int offset, int limit);
}