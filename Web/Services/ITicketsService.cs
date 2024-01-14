using Domain.Entities;

namespace Web.Services;

public interface ITicketsService
{
    Task<Ticket> Get(int id);
    
    Task<List<Ticket>> GetByEvent(int eventId);
    
    Task<Ticket> Create(Ticket ticket);
}