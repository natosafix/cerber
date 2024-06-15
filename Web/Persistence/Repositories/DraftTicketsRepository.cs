using Domain.Entities;
using Microsoft.EntityFrameworkCore;

namespace Web.Persistence.Repositories;

public interface IDraftTicketsRepository
{
    public Task<DraftTicket?> GetDraftTicketAsync(int draftTicketId);
    public Task<IReadOnlyCollection<DraftTicket>> GetDraftTicketsByEventIdAsync(int draftEventId);
    public Task SetDraftTicketsAsync(IReadOnlyCollection<DraftTicket> draftTickets);
}

public class DraftTicketsRepository : IDraftTicketsRepository
{
    private readonly CerberDbContext dbContext;

    public DraftTicketsRepository(CerberDbContext dbContext)
    {
        this.dbContext = dbContext;
    }

    public async Task<DraftTicket?> GetDraftTicketAsync(int draftTicketId)
    {
        return await dbContext.DraftTickets.FirstOrDefaultAsync(dt => dt.Id == draftTicketId);
    }

    public async Task<IReadOnlyCollection<DraftTicket>> GetDraftTicketsByEventIdAsync(int draftEventId)
    {
        return await dbContext.DraftTickets.Where(dt => dt.DraftEventId == draftEventId).ToListAsync();
    }

    public async Task SetDraftTicketsAsync(IReadOnlyCollection<DraftTicket> draftTickets)
    {
        var draftEventId = draftTickets.First().DraftEventId;
        
        await using var transaction = await dbContext.Database.BeginTransactionAsync();
        try
        {
            await dbContext.DraftTickets.Where(dt => dt.DraftEventId == draftEventId).ExecuteDeleteAsync();
            await dbContext.SaveChangesAsync();

            await dbContext.DraftTickets.AddRangeAsync(draftTickets);
            await dbContext.SaveChangesAsync();

            await transaction.CommitAsync();
        }
        catch (Exception)
        {
            await transaction.RollbackAsync();
            throw;
        }
    }
}