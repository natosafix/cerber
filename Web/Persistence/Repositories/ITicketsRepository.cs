using Domain.Entities;

namespace Web.Persistence.Repositories;

public interface ITicketsRepository
{
    Task<Ticket> Create(Ticket ticket);
}