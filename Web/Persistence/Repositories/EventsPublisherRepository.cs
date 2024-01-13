using Domain.Entities;
using Microsoft.EntityFrameworkCore;

namespace Web.Persistence.Repositories;

public interface IEventsPublisherRepository
{
    Task<int> Publish(
        DraftEvent srcDraftEvent,
        Event dstEvent,
        IReadOnlyCollection<Question> dstQuestions);
}

public class EventsPublisherRepository : IEventsPublisherRepository
{
    private readonly CerberDbContext dbContext;

    public EventsPublisherRepository(CerberDbContext dbContext)
    {
        this.dbContext = dbContext;
    }

    public async Task<int> Publish(
        DraftEvent srcDraftEvent,
        Event dstEvent,
        IReadOnlyCollection<Question> dstQuestions)
    {
        await using var transaction = await dbContext.Database.BeginTransactionAsync();
        try
        {
            await dbContext.DraftEvents.Where(de => de.Id == srcDraftEvent.Id).ExecuteDeleteAsync();
            await dbContext.SaveChangesAsync();

            await dbContext.DraftQuestions.Where(dq => dq.DraftEventId == srcDraftEvent.Id).ExecuteDeleteAsync();
            await dbContext.SaveChangesAsync();

            dstEvent = (await dbContext.Events.AddAsync(dstEvent)).Entity;
            await dbContext.SaveChangesAsync();

            foreach (var dstQuestion in dstQuestions)
                dstQuestion.EventId = dstEvent.Id;

            await dbContext.Questions.AddRangeAsync(dstQuestions);
            await dbContext.SaveChangesAsync();

            await transaction.CommitAsync();

            return dstEvent.Id;
        }
        catch (Exception)
        {
            await transaction.RollbackAsync();
            throw;
        }
    }
}