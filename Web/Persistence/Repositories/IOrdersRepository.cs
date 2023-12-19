using Domain.Entities;

namespace Web.Persistence.Repositories;

public interface IOrdersRepository
{
    Task<List<Order>> Get(int eventId);
    
    Task<Order> Create(Order order);
}