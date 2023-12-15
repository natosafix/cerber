using Domain.Entities;

namespace Web.Persistence.Repositories;

public interface IQuestionsRepository
{
    Task<Question> Create(Question question);
}