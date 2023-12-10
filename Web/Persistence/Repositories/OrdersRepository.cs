using Domain.Entities;

namespace Web.Persistence.Repositories;

public class OrdersRepository : IOrdersRepository
{
    private readonly CerberDbContext dbContext;
    public OrdersRepository(CerberDbContext dbContext)
    {
        this.dbContext = dbContext;
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