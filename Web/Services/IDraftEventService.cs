using Domain.Entities;

namespace Web.Services;

public interface IDraftEventService
{
    Task<DraftEvent> FindDraftByUserId(string userId);
}