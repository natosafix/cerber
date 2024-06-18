using Domain.Entities;
using Microsoft.EntityFrameworkCore;

namespace Web.Persistence.Repositories;

public interface IEventsPublisherRepository
{
    Task<int> Publish(
        DraftEvent srcDraftEvent,
        Event dstEvent,
        IReadOnlyCollection<Question> dstQuestions,
        IReadOnlyCollection<Ticket> dstTickets);
}

public class EventsPublisherRepository : IEventsPublisherRepository
{
    private readonly CerberDbContext dbContext;
    private readonly IEventsRepository eventsRepository;
    private readonly IUsersRepository usersRepository;

    public EventsPublisherRepository(CerberDbContext dbContext, IEventsRepository eventsRepository,
        IUsersRepository usersRepository)
    {
        this.dbContext = dbContext;
        this.eventsRepository = eventsRepository;
        this.usersRepository = usersRepository;
    }

    public async Task<int> Publish(
        DraftEvent srcDraftEvent,
        Event dstEvent,
        IReadOnlyCollection<Question> dstQuestions,
        IReadOnlyCollection<Ticket> dstTickets)
    {
        await using var transaction = await dbContext.Database.BeginTransactionAsync();
        try
        {
            await dbContext.DraftTickets.Where(dt => dt.DraftEventId == srcDraftEvent.Id).ExecuteDeleteAsync();
            await dbContext.SaveChangesAsync();
            
            await dbContext.DraftQuestions.Where(dq => dq.DraftEventId == srcDraftEvent.Id).ExecuteDeleteAsync();
            await dbContext.SaveChangesAsync();

            await dbContext.DraftEvents.Where(de => de.Id == srcDraftEvent.Id).ExecuteDeleteAsync();
            await dbContext.SaveChangesAsync();

            dstEvent = (await dbContext.Events.AddAsync(dstEvent)).Entity;
            await dbContext.SaveChangesAsync();

            foreach (var ticket in dstTickets)
                ticket.EventId = dstEvent.Id;

            await dbContext.Tickets.AddRangeAsync(dstTickets);
            await dbContext.SaveChangesAsync();

            foreach (var dstQuestion in dstQuestions)
                dstQuestion.EventId = dstEvent.Id;

            await dbContext.Questions.AddRangeAsync(dstQuestions);
            await dbContext.SaveChangesAsync();

            var userId = Guid.Parse(dstEvent.OwnerId);
            var inspector = await usersRepository.Get(userId) ??
                            throw new BadHttpRequestException($"Not found inspector with id {userId}");
            await eventsRepository.AddInspector(dstEvent, inspector);

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