using Domain.Entities;
using Web.Models;

namespace Web.Services;

public interface IEventsService
{
    Task<Event> Create(Event @event);
    Task AddInspector(int id, Guid inspector);
    Task<PageList<Event>> GetInspected(string username, int offset, int limit);
}