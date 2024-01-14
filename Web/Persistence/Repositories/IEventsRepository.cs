using Domain.Entities;
using Domain.Infrastructure;

namespace Web.Persistence.Repositories;

public interface IEventsRepository
{
    Task<Event?> Get(int id);

    Task<Event?> GetByTicketId(int ticketId);

    Task<Event?> GetWithInspectors(int id);
    
    Task<Event> Create(Event @event);
    
    Task AddInspector(Event @event, User inspector);

    Task<PageList<Event>> GetInspected(string username, int offset, int limit);
    
    Task<PageList<Event>> GetOwned(string username, int offset, int limit);
}