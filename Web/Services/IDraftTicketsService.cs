using Domain.Entities;
using Domain.Infrastructure;

namespace Web.Services;

public interface IDraftTicketsService
{
    Task<Result<DraftTicket>> GetDraftTicketAsync(int ticketId);
    Task<IReadOnlyCollection<DraftTicket>> GetDraftTicketsByEventIdAsync(int draftEventId);
    Task SetDraftTicketsAsync(IReadOnlyCollection<DraftTicket> newDraftTickets, int draftEventId);
}