using Domain.Entities;

namespace Web.Persistence.Repositories;

public class EventRepository : IEventRepository
{
    private readonly CerberDbContext cerberDbContext;
    
    public EventRepository(CerberDbContext cerberDbContext)
    {
        this.cerberDbContext = cerberDbContext;
    }

    public Event Create(Event @event)
    {
        throw new NotImplementedException();
    }
}