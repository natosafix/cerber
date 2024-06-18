using System.Diagnostics.CodeAnalysis;
using Domain.Entities;
using Domain.Infrastructure;
using Web.Persistence.Repositories;

namespace Web.Services.Implementations;

public class DraftTicketsService : IDraftTicketsService
{
    private readonly IDraftTicketsRepository draftTicketsRepository;
    private readonly IUserFilesService userFilesService;

    public DraftTicketsService(IDraftTicketsRepository draftTicketsRepository, IUserFilesService userFilesService)
    {
        this.draftTicketsRepository = draftTicketsRepository;
        this.userFilesService = userFilesService;
    }

    public async Task<Result<DraftTicket>> GetDraftTicketAsync(int ticketId)
    {
        var draftTicket = await draftTicketsRepository.GetDraftTicketAsync(ticketId);
        if (draftTicket is null)
            return "Can't find ticket";

        return draftTicket;
    }

    public async Task<IReadOnlyCollection<DraftTicket>> GetDraftTicketsByEventIdAsync(int draftEventId)
    {
        return await draftTicketsRepository.GetDraftTicketsByEventIdAsync(draftEventId);
    }

    public async Task SetDraftTicketsAsync(
        IReadOnlyCollection<DraftTicket> newDraftTickets,
        int draftEventId)
    {
        var oldDraftTickets = await GetDraftTicketsByEventIdAsync(draftEventId);

        foreach (var draftTicket in newDraftTickets)
            draftTicket.DraftEventId = draftEventId;

        await draftTicketsRepository.SetDraftTicketsAsync(newDraftTickets);

        foreach (var draftTicket in oldDraftTickets)
            await userFilesService.Remove(draftTicket.CoverImageId);
    }
}