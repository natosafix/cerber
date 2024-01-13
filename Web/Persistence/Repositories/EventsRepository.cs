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
    
    public async Task<Event?> GetByTicketId(int ticketId)
    {
        var ticket = await dbContext.Tickets
            .Include(t => t.Event)
            .FirstOrDefaultAsync(t => t.Id == ticketId);
        return ticket?.Event;
    }
    
    public async Task<Event?> GetWithInspectors(int id)
    {
        return await dbContext.Events
            .Include(e => e.Inspectors)
            .FirstOrDefaultAsync(e => e.Id.Equals(id));
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
       var events = await dbContext.Events.FromSqlInterpolated(
           $@"SELECT e.""Id"", e.""OwnerId"", e.""CategoryId"", e.""Address"", e.""City"", e.""Description"", e.""From"", e.""Name"", e.""ShortDescription"", e.""To"", e.""CoverId"", e.""CryptoKey""
              FROM ""EventUser"" as eu
              JOIN ""AspNetUsers"" as u on u.""Id"" = eu.""InspectorsId""
              JOIN events e on e.""Id"" = eu.""InspectedEventsId""
              WHERE u.""UserName"" = {username}
              OFFSET {offset} 
              LIMIT {limit}")
           .ToListAsync();
       
       return new PageList<Event>(events ?? new List<Event>(), offset, limit);
   }

   public async Task<PageList<Event>> GetOwned(string username, int offset, int limit)
   {
       var events = await dbContext.Events
           .Where(e => e.Owner.UserName.Equals(username))
           .Skip(offset)
           .Take(limit)
           .ToListAsync();

       return new PageList<Event>(events ?? new List<Event>(), offset, limit);
   }
}