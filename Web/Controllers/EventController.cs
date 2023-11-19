using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using Web.Models;

namespace Web.Controllers;

[Route("[controller]")]
public class EventController : Controller
{
    private readonly IMapper mapper;
    
    public EventController(IMapper mapper)
    {
        this.mapper = mapper;
    }

    [HttpPost("/")]
    public Task<IActionResult> Create([FromBody] CreateEventDto createEventDto)
    {
        throw new NotImplementedException();
    }
}