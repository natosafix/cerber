using AutoMapper;
using Domain.Entities;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Web.Models;
using Web.Services;

namespace Web.Controllers;

[Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
[Route("[controller]")]
public class EventsController : Controller
{
    private readonly IMapper mapper;
    private readonly IEventsService eventsService;
    private readonly IUserHelper userHelper;

    public EventsController(IMapper mapper, IEventsService eventsService, IUserHelper userHelper)
    {
        this.mapper = mapper;
        this.eventsService = eventsService;
        this.userHelper = userHelper;
    }
    
    [HttpGet("inspected")]
    public async Task<IActionResult> GetInspected([FromQuery] PaginationDto paginationDto)
    {
        var inspectedEvents = await eventsService.GetInspected(userHelper.Username, paginationDto.Offset, paginationDto.Limit);
        return Ok(mapper.Map<List<EventResponseDto>>(inspectedEvents));
    }
    
    [HttpGet("owned")]
    public async Task<IActionResult> GetOwned([FromQuery] PaginationDto paginationDto)
    {
        var ownedEvents = await eventsService.GetOwned(userHelper.Username, paginationDto.Offset, paginationDto.Limit);
        return Ok(mapper.Map<List<EventResponseDto>>(ownedEvents));
    }
    
    [HttpPost("")]
    [Produces("application/json")]
    public async Task<IActionResult> Create([FromBody] CreateEventDto createEventDto)
    {
        if (!ModelState.IsValid)
            return BadRequest(ModelState);
        
        return Ok(await eventsService.Create(mapper.Map<Event>(createEventDto)));
    }
    
    [HttpPut("{id}/inspector")]
    public async Task<IActionResult> AddInspector([FromRoute] int id, [FromBody] SetInspectorDto setInspectorDto)
    {
        if (!ModelState.IsValid)
            return BadRequest(ModelState);

        var inspectorId = Guid.Parse(setInspectorDto.Id);
        await eventsService.AddInspector(id, inspectorId);
        
        return NoContent();
    }
}