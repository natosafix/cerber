namespace Domain.Entities;

public class Event
{
    public int Id;
    
    public string Name;

    public string ShortDescription;

    public string Description;
    
    //Тут как то фотка мероприятия будет храниться, пока в мыслях - имя файла
    // Cover

    public string City;

    public string Address;

    public DateTimeOffset From;
    
    public DateTimeOffset To;
    
    public string OwnerId { get; set; }
    public User Owner { get; set; }
    
    public int CategoryId { get; set; }
    public Category Category { get; set; }
    
    public List<Ticket> Tickets { get; set; }
    
    public List<Question> Questions { get; set; }
    
    public List<User> Inspectors { get; set; }
}