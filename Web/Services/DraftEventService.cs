using Domain.Entities;

namespace Web.Services;

public class DraftEventService : IDraftEventService
{
    public Task<DraftEvent> FindDraftByUserId(string userId)
    {
        throw new NotImplementedException();
    }
}