using Domain.Entities;

namespace Web.Services;

public interface IDraftQuestionsService
{
    Task<IReadOnlyCollection<DraftQuestion>> GetDraftQuestionsByDraftEventIdAsync(int draftEventId);
    Task SetDraftQuestionsAsync(IReadOnlyCollection<DraftQuestion> draftQuestions, int dstDraftEventId);
}