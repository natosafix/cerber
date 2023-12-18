using Domain.Entities;
using Web.Persistence.Repositories;

namespace Web.Services;

public class QuestionsService : IQuestionsService
{
    private readonly IQuestionsRepository questionsRepository;
    private readonly IEventsService eventsService;
    
    public QuestionsService(IQuestionsRepository questionsRepository, IEventsService eventsService)
    {
        this.questionsRepository = questionsRepository;
        this.eventsService = eventsService;
    }

    public async Task<Question> Get(int id)
    {
        return await questionsRepository.Get(id) ?? throw new BadHttpRequestException($"Not found question with id {id}");
    }

    public async Task<List<Question>> GetByEvent(int eventId)
    {
        var @event = await eventsService.Get(eventId);
        return await questionsRepository.GetByEvent(@event);
    }

    public async Task<Question> Create(Question question)
    {
        return await questionsRepository.Create(question);
    }
}