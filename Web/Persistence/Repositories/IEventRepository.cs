using Domain.Entities;

namespace Web.Persistence.Repositories;

public interface IEventRepository
{
    Event Create(Event @event);
}