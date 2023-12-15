using Domain.Entities;

namespace Web.Persistence.Repositories;

public class AnswersRepository : IAnswersRepository
{
    private readonly CerberDbContext dbContext;
    
    public AnswersRepository(CerberDbContext dbContext)
    {
        this.dbContext = dbContext;
    }

    public async Task<Answer> Create(Answer answer)
    {
        var entity = (await dbContext.Answers.AddAsync(answer)).Entity;
        await dbContext.SaveChangesAsync();
        return entity;
    }
}