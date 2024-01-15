using AutoMapper;
using Domain.Entities;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Web.Dtos.Request;
using Web.Dtos.Response;
using Web.Services;
using Web.Services.Implementations;

namespace Web.Controllers;

[Authorize]
[Route("[controller]")]
public class EventsController : Controller
{
    private readonly IMapper mapper;
    private readonly IEventsService eventsService;
    private readonly IUserHelper userHelper;
    private readonly IUserFilesService userFilesService;

    public EventsController(
        IMapper mapper,
        IEventsService eventsService,
        IUserHelper userHelper, IUserFilesService userFilesService)
    {
        this.mapper = mapper;
        this.eventsService = eventsService;
        this.userHelper = userHelper;
        this.userFilesService = userFilesService;
    }

    [AllowAnonymous]
    [HttpGet("{id}")]
    public async Task<IActionResult> Get([FromRoute] int id)
    {
        var inspectedEvents = await eventsService.Get(id);
        return Ok(mapper.Map<EventResponseDto>(inspectedEvents));
    }

    [HttpGet("inspected")]
    public async Task<IActionResult> GetInspected([FromQuery] PaginationDto paginationDto)
    {
        var inspectedEvents =
            await eventsService.GetInspected(userHelper.Username, paginationDto.Offset, paginationDto.Limit);
        return Ok(mapper.Map<List<EventResponseDto>>(inspectedEvents));
    }

    [HttpGet("owned")]
    public async Task<IActionResult> GetOwned([FromQuery] PaginationDto paginationDto)
    {
        var ownedEvents = await eventsService.GetOwned(userHelper.Username, paginationDto.Offset, paginationDto.Limit);
        return Ok(mapper.Map<List<EventResponseDto>>(ownedEvents));
    }

    [HttpPost("")]
    public async Task<IActionResult> Create([FromBody] CreateEventDto createEventDto)
    {
        if (!ModelState.IsValid)
            return BadRequest(ModelState);

        var @event = mapper.Map<Event>(createEventDto);
        var createdEvent = await eventsService.Create(@event);
        var eventResponse = mapper.Map<EventResponseDto>(createdEvent);
        return Ok(eventResponse);
    }

    [Authorize("MustOwnEvent")]
    [HttpGet("{id}/inspectors")]
    public async Task<IActionResult> GetInspectors([FromRoute] int id)
    {
        return Ok(await eventsService.GetInspectors(id));
    }
    
    [Authorize("MustOwnEvent")]
    [HttpPut("{id}/inspector")]
    public async Task<IActionResult> AddInspector([FromRoute] int id, [FromBody] SetInspectorDto setInspectorDto)
    {
        if (!ModelState.IsValid)
            return BadRequest(ModelState);

        var inspectorId = Guid.Parse(setInspectorDto.Id);
        await eventsService.AddInspector(id, inspectorId);

        return NoContent();
    }
    
    [Authorize("MustOwnEvent")]
    [HttpPut("{id}/inspectorByUsername")]
    public async Task<IActionResult> AddInspectorByUsername([FromRoute] int id, [FromBody] SetInspectorByUsernameDto setInspectorDto)
    {
        if (!ModelState.IsValid)
            return BadRequest(ModelState);
        
        await eventsService.AddInspectorByUsername(id, setInspectorDto.Username);

        return NoContent();
    }
    
    [Authorize("MustOwnEvent")]
    [HttpDelete("{id}/inspector")]
    public async Task<IActionResult> DeleteInspector([FromRoute] int id, [FromQuery] string username)
    {
        await eventsService.DeleteInspector(id, username);

        return NoContent();
    }
    
    [AllowAnonymous]
    [HttpGet("{id}/cover")]
    public async Task<IActionResult> GetCover([FromRoute] int id)
    {
        var @event = await eventsService.Get(id);
        var userFile = await userFilesService.Get(@event.CoverId!.Value);
        var bytes = await userFilesService.GetContent(userFile);
        return File(bytes, "APPLICATION/octet-stream", userFile.Name);
    }
}