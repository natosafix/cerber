using Domain.Entities;
using Web.Persistence.Repositories;

namespace Web.Services;

public class TicketsService : ITicketsService
{
    private readonly ITicketsRepository ticketsRepository;
    
    public TicketsService(ITicketsRepository ticketsRepository)
    {
        this.ticketsRepository = ticketsRepository;
    }

    public async Task<Ticket> Create(Ticket ticket)
    {
        return await ticketsRepository.Create(ticket);
    }
}