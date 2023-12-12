using Domain.Entities;
using Web.Persistence.Repositories;

namespace Web.Services;

public class AnswersService : IAnswersService
{
    private readonly IAnswersRepository answersRepository;
    
    public AnswersService(IAnswersRepository answersRepository)
    {
        this.answersRepository = answersRepository;
    }

    public async Task<Answer> Create(Answer answer)
    {
        return await answersRepository.Create(answer);
    }
}