using System.ComponentModel.DataAnnotations;

namespace Web.Dtos.Request;

public class SetInspectorByUsernameDto
{
    [Required]
    public string Username { get; set; }
}