using Domain.Entities;
using Web.Models;

namespace Web.Persistence.Repositories;

public interface IEventsRepository
{
    Task<Event> Create(Event @event);
    
    Task AddInspector(int id, User inspector);

    PageList<Event> GetInspected(string username, int offset, int limit);
}