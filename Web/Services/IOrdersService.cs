using Domain.Entities;

namespace Web.Services;

public interface IOrdersService
{
    Task<List<Order>> Get(int eventId);
    
    Task<Order> Create(Order order);
}