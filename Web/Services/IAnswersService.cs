using Domain.Entities;

namespace Web.Services;

public interface IAnswersService
{
    Task<Answer> Create(Answer answer);
}