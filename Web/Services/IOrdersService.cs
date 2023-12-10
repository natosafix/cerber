using Domain.Entities;

namespace Web.Services;

public interface IOrdersService
{
    Task<Order> Create(Order order);
}