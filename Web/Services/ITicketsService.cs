using Domain.Entities;

namespace Web.Services;

public interface ITicketsService
{
    Task<Ticket> Create(Ticket ticket);
}