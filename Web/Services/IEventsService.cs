using Domain.Entities;

namespace Web.Services;

public interface IEventsService
{
    public Task<Event> Create(Event @event);
    public Task<List<Event>> GetInspected(string username);
}