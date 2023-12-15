using Newtonsoft.Json;

namespace Domain.Entities;

public class Category
{
    public int Id { get; set; }
    
    public string Name { get; set; }
    
    [JsonIgnore]
    public List<Event> Events { get; set; }
}