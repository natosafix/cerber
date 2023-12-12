using Domain.Entities;

namespace Web.Persistence.Repositories;

public class EventsRepository : IEventsRepository
{
    private readonly CerberDbContext dbContext;
    
    public EventsRepository(CerberDbContext dbContext)
    {
        this.dbContext = dbContext;
    }

   public async Task<Event> Create(Event @event)
   {
       var entity = (await dbContext.Events
           .AddAsync(@event))
           .Entity;
       await dbContext.SaveChangesAsync();
       return entity;
   }

   public async Task AddInspector(int id, User inspector)
   {
       var @event = await dbContext.Events.FindAsync(id);
       @event.Inspectors = @event.Inspectors ?? new List<User>();
       @event.Inspectors.Add(inspector);
       dbContext.Events.Update(@event);
       await dbContext.SaveChangesAsync();
   }
}