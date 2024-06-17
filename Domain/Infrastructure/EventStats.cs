namespace Domain.Infrastructure;

public class EventStats
{
    public int SoldTicketsCount;
    public TicketStats[] TicketsStats = Array.Empty<TicketStats>();
    public Dictionary<string, TicketStats[]> TicketsByInspector = new();
    public string[] Inspectors = Array.Empty<string>();
}