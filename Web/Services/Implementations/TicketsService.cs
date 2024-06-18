using Domain.Entities;
using Web.Persistence.Repositories;

namespace Web.Services.Implementations;

public class TicketsService : ITicketsService
{
    private readonly ITicketsRepository ticketsRepository;
    
    public TicketsService(ITicketsRepository ticketsRepository)
    {
        this.ticketsRepository = ticketsRepository;
    }

    public async Task<Ticket> Get(int id)
    {
        return await ticketsRepository.Get(id) ?? throw new BadHttpRequestException($"Not found ticket with id {id}");
    }

    public async Task<List<Ticket>> GetByEvent(int eventId)
    {
        var tickets = await ticketsRepository.GetByEvent(eventId);
        if (!tickets.Any())
            throw new BadHttpRequestException($"Not found tickets with eventId {eventId}");
        return tickets;
    }

    public async Task<Ticket> Create(Ticket ticket)
    {
        return await ticketsRepository.Create(ticket);
    }
}