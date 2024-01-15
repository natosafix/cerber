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

    public Task<Order?> Get(Guid customer)
    {
        return dbContext.Orders
            .Include(o => o.Ticket)
            .Include(o => o.Answers)
            .ThenInclude(a => a.Question)
            .FirstOrDefaultAsync(o => o.Customer.Equals(customer));
    }

    public Task<List<Order>> GetByEvent(int eventId)
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
        var result = await dbContext.Orders.AddAsync(order);
        await dbContext.SaveChangesAsync();
        return result.Entity;
    }
    
    public async Task SetPaid(Guid customer)
    {
        await dbContext.Orders
            .Where(o => o.Customer.Equals(customer))
            .ExecuteUpdateAsync(sp => sp.SetProperty(o => o.Paid, true));
        await dbContext.SaveChangesAsync();
    }
}