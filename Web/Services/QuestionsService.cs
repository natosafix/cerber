using Domain.Entities;
using Web.Persistence.Repositories;

namespace Web.Services;

public class QuestionsService : IQuestionsService
{
    private readonly IQuestionsRepository questionsRepository;
    
    public QuestionsService(IQuestionsRepository questionsRepository)
    {
        this.questionsRepository = questionsRepository;
    }

    public async Task<Question> Create(Question question)
    {
        return await questionsRepository.Create(question);
    }
}