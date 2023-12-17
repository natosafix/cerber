using Domain.Entities;
using Web.Persistence.Repositories;

namespace Web.Services;

public class OrdersService : IOrdersService
{
    private readonly IOrdersRepository ordersRepository;
    
    public OrdersService(IOrdersRepository ordersRepository)
    {
        this.ordersRepository = ordersRepository;
    }

    public Task<List<Order>> Get(int eventId)
    {
        return ordersRepository.Get(eventId);
    }

    public async Task<Order> Create(Order order)
    {
        order.Customer = Guid.NewGuid();
        return await ordersRepository.Create(order);
    }
}