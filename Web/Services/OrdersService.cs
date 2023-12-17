using Domain.Entities;
using Web.Persistence.Repositories;

namespace Web.Services;

public class OrdersService : IOrdersService
{
    private readonly IOrdersRepository ordersRepository;
    private readonly IMailService mailService;
    
    public OrdersService(IOrdersRepository ordersRepository, IMailService mailService)
    {
        this.ordersRepository = ordersRepository;
        this.mailService = mailService;
    }

    public Task<List<Order>> Get(int eventId)
    {
        return ordersRepository.Get(eventId);
    }

    public async Task<Order> Create(Order order)
    {
        order.Customer = Guid.NewGuid();
        order = await ordersRepository.Create(order);
        // await mailService.Send("imya", "mail", order);
        return order;
    }
}