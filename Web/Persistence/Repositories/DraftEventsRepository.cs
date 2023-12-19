using Domain.Entities;
using Microsoft.EntityFrameworkCore;

namespace Web.Persistence.Repositories;

public interface IDraftEventsRepository
{
    Task<DraftEvent?> FindDraftAsync(string ownerId);
    Task<DraftEvent?> AddAsync(string ownerId);
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
        var result = await dbContext.DraftEvents.Where(draft => draft.OwnerId == ownerId).FirstOrDefaultAsync();
        return result;
    }

    public async Task<DraftEvent?> AddAsync(string ownerId)
    {
        var newDraft = new DraftEvent() {OwnerId = ownerId};
        var result = await dbContext.DraftEvents.AddAsync(newDraft);
        await dbContext.SaveChangesAsync();
        return result.Entity;
    }
}