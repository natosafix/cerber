using Domain.Entities;

namespace Web.Services;

public interface IDraftQuestionsService
{
    Task<IReadOnlyCollection<DraftQuestion>> GetDraftQuestionsByDraftEventId(int draftEventId);
    Task SetDraftQuestions(IReadOnlyCollection<DraftQuestion> draftQuestions, int dstDraftEventId);
}