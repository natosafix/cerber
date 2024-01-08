using Domain.Entities;
using Microsoft.EntityFrameworkCore;

namespace Web.Persistence.Repositories;

public interface IDraftQuestionRepository
{
    Task<IReadOnlyCollection<DraftQuestion>> GetDraftQuestionsByDraftEventIdAsync(int draftEventId);
    Task SetDraftQuestionsAsync(IReadOnlyCollection<DraftQuestion> draftQuestions);
}

public class DraftQuestionRepository : IDraftQuestionRepository
{
    private readonly CerberDbContext dbContext;

    public DraftQuestionRepository(CerberDbContext dbContext)
    {
        this.dbContext = dbContext;
    }

    public async Task<IReadOnlyCollection<DraftQuestion>> GetDraftQuestionsByDraftEventIdAsync(int draftEventId)
    {
        return await dbContext.DraftQuestions
            .Where(dq => dq.DraftEventId == draftEventId)
            .ToListAsync();
    }

    public async Task SetDraftQuestionsAsync(IReadOnlyCollection<DraftQuestion> draftQuestions)
    {
        var draftEventId = draftQuestions.First().DraftEventId;

        await using var transaction = await dbContext.Database.BeginTransactionAsync();
        try
        {
            await dbContext.DraftQuestions
                .Where(dq => dq.DraftEventId == draftEventId)
                .ExecuteDeleteAsync();
            await dbContext.SaveChangesAsync();

            await dbContext.DraftQuestions.AddRangeAsync(draftQuestions);
            await dbContext.SaveChangesAsync();

            await transaction.CommitAsync();
        }
        catch (Exception)
        {
            await transaction.RollbackAsync();
            throw;
        }
    }
}