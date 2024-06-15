namespace Domain.Infrastructure;

public class EventStats
{
    public int SoldTicketsCount;
    public int TotalProfit;
    public Dictionary<string, int> TicketsInfo = new();
    public Dictionary<string, int> TicketsByInspector = new();
}