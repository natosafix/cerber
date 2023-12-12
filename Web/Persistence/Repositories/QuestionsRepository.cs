using Domain.Entities;

namespace Web.Persistence.Repositories;

public class QuestionsRepository : IQuestionsRepository
{
    private readonly CerberDbContext dbContext;
    
    public QuestionsRepository(CerberDbContext dbContext)
    {
        this.dbContext = dbContext;
    }

    public async Task<Question> Create(Question answer)
    {
        var entity = (await dbContext.Questions.AddAsync(answer)).Entity;
        await dbContext.SaveChangesAsync();
        return entity;
    }
}