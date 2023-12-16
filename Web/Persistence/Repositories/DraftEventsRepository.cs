using Domain.Entities;

namespace Web.Persistence.Repositories;

public interface IDraftEventsRepository
{
    Task<DraftEvent> CreateDraft(string ownerId);
}

public class DraftEventsRepository : IDraftEventsRepository
{
    private readonly CerberDbContext dbContext;

    public DraftEventsRepository(CerberDbContext dbContext)
    {
        this.dbContext = dbContext;
    }

    public async Task<DraftEvent> CreateDraft(string ownerId)
    {
        var newEvent = new DraftEvent {OwnerId = ownerId};
        var result = await dbContext.DraftEvents.AddAsync(newEvent);
        return result.Entity;
    }
}