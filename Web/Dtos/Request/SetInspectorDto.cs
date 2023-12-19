using System.ComponentModel.DataAnnotations;

namespace Web.Dtos.Request;

public class SetInspectorDto
{
    [Required]
    public string Id { get; set; }
}