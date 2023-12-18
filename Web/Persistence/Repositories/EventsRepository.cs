using Domain.Entities;
using Domain.Infrastructure;
using Microsoft.EntityFrameworkCore;

namespace Web.Persistence.Repositories;

public class EventsRepository : IEventsRepository
{
    private readonly CerberDbContext dbContext;
    
    public EventsRepository(CerberDbContext dbContext)
    {
        this.dbContext = dbContext;
    }

    public async Task<Event?> Get(int id)
    {
        return await dbContext.Events.FindAsync(id);
    }

    public async Task<Event> Create(Event @event)
   {
       var entity = (await dbContext.Events
           .AddAsync(@event))
           .Entity;
       await dbContext.SaveChangesAsync();
       return entity;
   }

   public async Task AddInspector(Event @event, User inspector)
   {
       @event.Inspectors ??= new List<User>();
       @event.Inspectors.Add(inspector);
       dbContext.Events.Update(@event);
       await dbContext.SaveChangesAsync();
   }

   public async Task<PageList<Event>> GetInspected(string username, int offset, int limit)
   {
       var events = (await dbContext.Users
               .Include(u => u.InspectedEvents)
               .FirstOrDefaultAsync(u => u.UserName.Equals(username)))
           ?.InspectedEvents
           .Skip(offset)
           .Take(limit);
       
       return new PageList<Event>(events ?? new List<Event>(), offset, limit);
   }

   public async Task<PageList<Event>> GetOwned(string username, int offset, int limit)
   {
       var events = (await dbContext.Users
               .Include(u => u.OwnedEvents)
               .FirstOrDefaultAsync(u => u.UserName.Equals(username)))
           ?.OwnedEvents
           .Skip(offset)
           .Take(limit);

       return new PageList<Event>(events ?? new List<Event>(), offset, limit);
   }
}