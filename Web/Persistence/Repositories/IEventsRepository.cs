using Domain.Entities;

namespace Web.Persistence.Repositories;

public interface IEventsRepository
{
    Task<Event> Create(Event @event);
    
    Task AddInspector(int id, User inspector);
}