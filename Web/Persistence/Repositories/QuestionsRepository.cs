using Domain.Entities;
using Microsoft.EntityFrameworkCore;

namespace Web.Persistence.Repositories;

public class QuestionsRepository : IQuestionsRepository
{
    private readonly CerberDbContext dbContext;
    
    public QuestionsRepository(CerberDbContext dbContext)
    {
        this.dbContext = dbContext;
    }

    public async Task<Question?> Get(int id)
    {
        return await dbContext.Questions.FindAsync(id);
    }

    public Task<List<Question>> GetByEvent(Event @event)
    {
        return dbContext.Questions
            .Where(q => q.Event.Id.Equals(@event.Id))
            .ToListAsync();
    }

    public async Task<Question> Create(Question answer)
    {
        var entity = (await dbContext.Questions.AddAsync(answer)).Entity;
        await dbContext.SaveChangesAsync();
        return entity;
    }
}