using Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Web.Models;

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

   public async Task<PageList<Event>> GetInspected(string username, int offset, int limit)
   {
       var events = (await dbContext.Users
           .Where(u => u.UserName.Equals(username))
           .Select(u => u.InspectedEvents)
           .FirstOrDefaultAsync())
           ?.Skip(offset)
           .Take(limit);
       
       return new PageList<Event>(events ?? new List<Event>(), offset, limit);
   }

   public async Task<PageList<Event>> GetOwned(string username, int offset, int limit)
   {
       var events = (await dbContext.Users
               .Where(u => u.UserName.Equals(username))
               .Select(u => u.OwnedEvents)
               .FirstOrDefaultAsync())
           ?.Skip(offset)
           .Take(limit);
       
       return new PageList<Event>(events ?? new List<Event>(), offset, limit);
   }
}