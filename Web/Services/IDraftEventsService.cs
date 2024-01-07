using Domain.Entities;

namespace Web.Services;

public interface IDraftEventsService
{
    Task<DraftEvent?> FindDraftByUserIdAsync(string userId);
    Task UpdateDraft(DraftEvent draftEvent);
    Task<DraftEvent?> CreateDraftAsync(string ownerId);
}