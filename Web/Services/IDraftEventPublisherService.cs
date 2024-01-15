using Domain.Entities;

namespace Web.Services;

public interface IDraftEventPublisherService
{
    Task<int> Publish(
        DraftEvent srcDraftEvent,
        Event dstEvent,
        IReadOnlyCollection<Question> dstQuestions,
        IReadOnlyCollection<Ticket> tickets);
}