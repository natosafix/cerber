using Domain.Entities;
using Microsoft.EntityFrameworkCore;

namespace Web.Persistence.Repositories;

public class TicketsRepository : ITicketsRepository
{
    private readonly CerberDbContext dbContext;
    
    public TicketsRepository(CerberDbContext dbContext)
    {
        this.dbContext = dbContext;
    }

    public async Task<Ticket?> Get(int id)
    {
        return await dbContext.Tickets
            .FindAsync(id);
    }

    public Task<List<Ticket>> GetByEvent(int eventId)
    {
        return dbContext.Tickets
            .Where(t => t.EventId.Equals(eventId))
            .ToListAsync();
    }

    public async Task<Ticket> Create(Ticket ticket)
    {
        var entity = (await dbContext.Tickets
            .AddAsync(ticket))
            .Entity;
        await dbContext.SaveChangesAsync();
        return entity;
    }
}