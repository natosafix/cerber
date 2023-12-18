using Domain.Entities;

namespace Web.Persistence.Repositories;

public interface IQuestionsRepository
{
    Task<Question?> Get(int id);
    
    Task<List<Question>> GetByEvent(Event @event);
    
    Task<Question> Create(Question question);
}