using Domain.Entities;

namespace Web.Services;

public interface IOrdersService
{
    Task<Order> Get(Guid customer);
    
    Task<List<Order>> GetByEvent(int eventId);
    
    Task<Order> Create(Order order);
}