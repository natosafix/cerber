using Domain.Entities;
using Web.Persistence.Repositories;

namespace Web.Services;

public class DraftEventService : IDraftEventService
{
    private readonly IDraftEventsRepository draftEventsRepository;

    public DraftEventService(IDraftEventsRepository draftEventsRepository)
    {
        this.draftEventsRepository = draftEventsRepository;
    }

    public async Task<DraftEvent?> FindDraftByUserIdAsync(string userId)
    {
        return await draftEventsRepository.FindDraftAsync(userId);
    }

    public async Task<DraftEvent?> CreateDraftAsync(string ownerId)
    {
        return await draftEventsRepository.AddAsync(ownerId);
    }
}