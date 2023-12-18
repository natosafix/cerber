using Domain.Entities;
using Web.Persistence.Repositories;

namespace Web.Services;

public class AnswersService : IAnswersService
{
    private readonly IAnswersRepository answersRepository;
    
    public AnswersService(IAnswersRepository answersRepository, ILogger<AnswersService> logger)
    {
        this.answersRepository = answersRepository;
    }

    public async Task<Answer> Create(Answer answer)
    {
        var answerCreated = await answersRepository.Create(answer);
        
        return answerCreated;
    }
}