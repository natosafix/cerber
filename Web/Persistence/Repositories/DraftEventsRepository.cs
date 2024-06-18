using Domain.Entities;
using Microsoft.EntityFrameworkCore;

namespace Web.Persistence.Repositories;

public interface IDraftEventsRepository
{
    Task<DraftEvent?> FindDraftAsync(string ownerId);
    Task UpdateAsync(DraftEvent draftEvent);
    Task<DraftEvent?> CreateAsync(string ownerId);
}

public class DraftEventsRepository : IDraftEventsRepository
{
    private readonly CerberDbContext dbContext;

    public DraftEventsRepository(CerberDbContext dbContext)
    {
        this.dbContext = dbContext;
    }

    public async Task<DraftEvent?> FindDraftAsync(string ownerId)
    {
        var result = await dbContext.DraftEvents.FirstOrDefaultAsync(draft => draft.OwnerId == ownerId);
        return result;
    }

    public async Task UpdateAsync(DraftEvent draftEvent)
    {
        await using var transaction = await dbContext.Database.BeginTransactionAsync();
        try
        {
            var result = await dbContext.DraftEvents.FirstOrDefaultAsync(draft => draft.Id == draftEvent.Id);
            dbContext.DraftEvents.Remove(result!);
            await dbContext.SaveChangesAsync();

            await dbContext.DraftEvents.AddAsync(draftEvent);
            await dbContext.SaveChangesAsync();

            await transaction.CommitAsync();
        }
        catch (Exception)
        {
            await transaction.RollbackAsync();
            throw;
        }
    }

    public async Task<DraftEvent?> CreateAsync(string ownerId)
    {
        var newDraft = new DraftEvent() {OwnerId = ownerId};
        var result = await dbContext.DraftEvents.AddAsync(newDraft);
        await dbContext.SaveChangesAsync();
        return result.Entity;
    }
}