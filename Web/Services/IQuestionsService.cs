using Domain.Entities;

namespace Web.Services;

public interface IQuestionsService
{
    Task<Question> Create(Question question);
}