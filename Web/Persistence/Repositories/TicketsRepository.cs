using Domain.Entities;

namespace Web.Persistence.Repositories;

public class TicketsRepository : ITicketsRepository
{
    private readonly CerberDbContext dbContext;
    
    public TicketsRepository(CerberDbContext dbContext)
    {
        this.dbContext = dbContext;
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