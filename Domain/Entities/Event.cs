namespace Domain.Entities;

public class Event
{
    public Guid Id;
    
    public string Name;

    public string ShortDescription;

    public string Description;
    
    //Тут как то фотка мероприятия будет храниться, пока в мыслях - имя файла
    // Cover

    public string City;

    public string Address;

    public DateTimeOffset From;
    
    public DateTimeOffset To;
    
    public int QuizId { get; set; }
    public Quiz Quiz { get; set; }
    
    public int CategoryId { get; set; }
    public Category Category { get; set; }
    
    public List<Ticket> Tickets { get; set; }
}