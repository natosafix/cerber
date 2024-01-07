using Domain.Entities;
using Web.Persistence.Repositories;

namespace Web.Services.Implementations;

public class DraftEventsService : IDraftEventsService
{
    private readonly IDraftEventsRepository draftEventsRepository;

    public DraftEventsService(IDraftEventsRepository draftEventsRepository)
    {
        this.draftEventsRepository = draftEventsRepository;
    }

    public async Task<DraftEvent?> FindDraftByUserIdAsync(string userId)
    {
        return await draftEventsRepository.FindDraftAsync(userId);
    }

    public async Task UpdateDraft(DraftEvent draftEvent)
    {
        await draftEventsRepository.UpdateAsync(draftEvent);
    }

    public async Task<DraftEvent?> CreateDraftAsync(string ownerId)
    {
        return await draftEventsRepository.AddAsync(ownerId);
    }
}