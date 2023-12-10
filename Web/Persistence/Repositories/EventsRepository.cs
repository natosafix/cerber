using Domain.Entities;

namespace Web.Persistence.Repositories;

public class EventsRepository : IEventsRepository
{
    private readonly CerberDbContext cerberDbContext;
    
    public EventsRepository(CerberDbContext cerberDbContext)
    {
        this.cerberDbContext = cerberDbContext;
    }

   public async Task<Event> Create(Event @event)
   {
       var entity = (await cerberDbContext.Events
           .AddAsync(@event))
           .Entity;
       await cerberDbContext.SaveChangesAsync();
       return entity;
   }
}