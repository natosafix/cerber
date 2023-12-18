using Domain.Entities;

namespace Web.Services;

public interface IQuestionsService
{
    Task<Question> Get(int id);
    
    Task<List<Question>> GetByEvent(int eventId);
    
    Task<Question> Create(Question question);
}