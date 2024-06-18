using System.Security.Cryptography;
using Domain.Entities;
using Domain.Infrastructure;
using Web.Persistence.Repositories;

namespace Web.Services.Implementations;

public class EventsService : IEventsService
{
    private readonly IUsersRepository usersRepository;
    private readonly IEventsRepository eventsRepository;
    private readonly IOrdersRepository ordersRepository;

    public EventsService(IUsersRepository usersRepository, IEventsRepository eventsRepository, IOrdersRepository ordersRepository)
    {
        this.usersRepository = usersRepository;
        this.eventsRepository = eventsRepository;
        this.ordersRepository = ordersRepository;
    }

    public async Task<Event> Get(int id)
    {
       return await eventsRepository.Get(id) ?? throw new BadHttpRequestException($"Not found event with id {id}");
    }
    
    public async Task<Event> GetByTicketId(int ticketId)
    {
        return await eventsRepository.GetByTicketId(ticketId) ?? throw new BadHttpRequestException($"Not found event by ticketId {ticketId}");
    }
    
    public async Task<Event> GetWithInspectors(int id)
    {
        return await eventsRepository.GetWithInspectors(id) ?? throw new BadHttpRequestException($"Not found event with id {id}");
    }

    public async Task<Event> Create(Event @event)
    {
        var bytes = new byte[16];
        RandomNumberGenerator.Create().GetBytes(bytes);
        @event.CryptoKey = Convert.ToBase64String(bytes);
        return await eventsRepository.Create(@event);
    }

    public Task<List<string>> GetInspectors(int id)
    {
        return eventsRepository.GetInspectors(id);
    }

    public async Task AddInspector(int id, Guid inspectorId)
    {
        var inspector = await usersRepository.Get(inspectorId) ?? throw new BadHttpRequestException($"Not found inspector with id {inspectorId}");
        var @event = await Get(id);
        await eventsRepository.AddInspector(@event, inspector);
    }

    public async Task AddInspectorByUsername(int id, string username)
    {
        var inspector = await usersRepository.Get(username) ?? throw new BadHttpRequestException($"Not found inspector with username {username}");
        var @event = await Get(id);
        await eventsRepository.AddInspector(@event, inspector);
    }

    public async Task DeleteInspector(int id, string username)
    {
        var @event = await GetWithInspectors(id);
        await eventsRepository.DeleteInspector(@event, username);
    }
    
    public async Task<PageList<Event>> GetInspected(string username, int offset, int limit)
    {
        return await eventsRepository.GetInspected(username, offset, limit);
    }

    public async Task<PageList<Event>> GetOwned(string username, int offset, int limit)
    {
        return await eventsRepository.GetOwned(username, offset, limit);
    }

    public async Task<PageList<Event>> GetIncoming(int offset, int limit)
    {
        return await eventsRepository.GetIncoming(offset, limit);
    }

    public async Task<EventStats> GetStats(int id)
    {
        var stats = new EventStats();
        var orders = await ordersRepository.GetByEvent(id);
        var paidOrders = orders.Where(o => o.Paid).ToList();
        var tickets = paidOrders.Select(o => o.Ticket).DistinctBy(t => t.Name).ToArray();
        var ticket2Count = new Dictionary<string, int>();
        var inspector2Tickets = new Dictionary<string, Dictionary<string, int>>();
        foreach (var paidOrder in paidOrders)
        {
            var ticketName = paidOrder.Ticket.Name;
            ticket2Count.TryAdd(ticketName, 0);
            ticket2Count[ticketName]++;
            if (paidOrder.InspectorName is null)
                continue;
            inspector2Tickets.TryAdd(paidOrder.InspectorName, new Dictionary<string, int>());
            inspector2Tickets[paidOrder.InspectorName].TryAdd(ticketName, 0);
            inspector2Tickets[paidOrder.InspectorName][ticketName]++;
        }

        stats.SoldTicketsCount = paidOrders.Count;
        stats.TicketsStats = ToTicketStatsArray(ticket2Count, tickets);
        stats.TicketsByInspector = inspector2Tickets.ToDictionary(pair => pair.Key, pair => ToTicketStatsArray(pair.Value, tickets));
        stats.Inspectors = paidOrders
            .Where(po => po.InspectorName is not null)
            .Select(po => po.InspectorName!)
            .Distinct()
            .ToArray();
        
        return stats;
    }

    private static TicketStats[] ToTicketStatsArray(Dictionary<string, int> tickets2Count, Ticket[] tickets)
    {
        return tickets2Count
            .Select(pair => new TicketStats(pair.Key, pair.Value, tickets.First(t => t.Name == pair.Key).Price))
            .ToArray();
    }
}