using Domain.Entities;

namespace Web.Services;

public interface IDraftEventService
{
    Task<DraftEvent?> FindDraftByUserIdAsync(string userId);
    Task<DraftEvent?> CreateDraftAsync(string ownerId);
}