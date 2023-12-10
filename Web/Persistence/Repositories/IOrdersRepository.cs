using Domain.Entities;

namespace Web.Persistence.Repositories;

public interface IOrdersRepository
{
    Task<Order> Create(Order order);
}