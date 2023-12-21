using Domain.Entities;

namespace Web.Persistence.Repositories;

public interface IOrdersRepository
{
    Task<Order?> Get(Guid customer);
    
    Task<List<Order>> GetByEvent(int eventId);
    
    Task<Order> Create(Order order);
}