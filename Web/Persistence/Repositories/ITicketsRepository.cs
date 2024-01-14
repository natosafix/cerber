using Domain.Entities;

namespace Web.Persistence.Repositories;

public interface ITicketsRepository
{
    Task<Ticket?> Get(int id);
    
    Task<List<Ticket>> GetByEvent(int eventId);
    
    Task<Ticket> Create(Ticket ticket);
}