using AutoMapper;
using Domain.Entities;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Web.Models;
using Web.Services;

namespace Web.Controllers;

[Authorize]
[Route("[controller]")]
public class EventsController : Controller
{
    private readonly IMapper mapper;
    private readonly IEventsService eventsService;

    public EventsController(IMapper mapper, IEventsService eventsService)
    {
        this.mapper = mapper;
        this.eventsService = eventsService;
    }
    
    [HttpGet("inspected")]
    public async Task<IActionResult> Get()
    {
        return Ok(await eventsService.GetInspected(User.Identity!.Name!));
    }
    
    [HttpPost("")]
    [Produces("application/json")]
    public async Task<IActionResult> Create([FromBody] CreateEventDto createEventDto)
    {
        if (!ModelState.IsValid)
            return BadRequest(ModelState);
        
        return Ok(await eventsService.Create(mapper.Map<Event>(createEventDto)));
    }
    
}