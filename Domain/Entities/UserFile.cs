using Newtonsoft.Json;

namespace Domain.Entities;

public class UserFile
{
    public Guid Id { get; set; }

    public string Name { get; set; }
    
    public string Path { get; set; }
}