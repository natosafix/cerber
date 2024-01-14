using Domain.Entities;

namespace Web.Services.Validators;

public interface IDraftEventValidator
{
    bool IsValid(DraftEvent draftEvent);
}

public class DraftEventValidator : IDraftEventValidator
{
    public bool IsValid(DraftEvent draftEvent)
    {
        return draftEvent.Title is not null &&
               draftEvent.Description is not null &&
               draftEvent.City is not null &&
               draftEvent.Address is not null &&
               draftEvent.From is not null &&
               draftEvent.To is not null &&
               draftEvent.From > DateTime.Now && 
               draftEvent.From <= draftEvent.To;
    }
}