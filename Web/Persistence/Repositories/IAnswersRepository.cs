using Domain.Entities;

namespace Web.Persistence.Repositories;

public interface IAnswersRepository
{
    Task<Answer> Create(Answer answer);
}