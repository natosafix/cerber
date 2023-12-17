using Domain.Entities;
using Microsoft.EntityFrameworkCore;

namespace Web.Persistence.Repositories;

public class OrdersRepository : IOrdersRepository
{
    private readonly CerberDbContext dbContext;
    public OrdersRepository(CerberDbContext dbContext)
    {
        this.dbContext = dbContext;
    }

    public Task<List<Order>> Get(int eventId)
    {
        return dbContext.Orders
            .Where(o => o.Ticket.EventId.Equals(eventId))
            .Include(o => o.Ticket)
            .Include(o => o.Answers)
            .ThenInclude(a => a.Question)
            .ToListAsync();
    }

    public async Task<Order> Create(Order order)
    {
        var entity = (await dbContext.Orders
                .AddAsync(order))
            .Entity;
        await dbContext.SaveChangesAsync();
        return entity;
    }
}