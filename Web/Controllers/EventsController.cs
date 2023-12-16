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
    private readonly IDraftEventService draftEventService;
    private readonly IUserHelper userHelper;

    public EventsController(IMapper mapper, IEventsService eventsService, IDraftEventService draftEventService, IUserHelper userHelper)
    {
        this.mapper = mapper;
        this.eventsService = eventsService;
        this.draftEventService = draftEventService;
        this.userHelper = userHelper;
    }

    [HttpGet("inspected")]
    public async Task<IActionResult> GetInspected([FromQuery] PaginationDto paginationDto)
    {
        var inspectedEvents =
            await eventsService.GetInspected(User.Identity!.Name!, paginationDto.Offset, paginationDto.Limit);
        return Ok(mapper.Map<List<EventResponseDto>>(inspectedEvents));
    }

    [HttpPost("createDraft")]
    public async Task<IActionResult> CreateDraft()
    {
        var user = await userHelper.GetUser();
        if (user is null)
            return Unauthorized();
        
        var draft = await draftEventService.FindDraftByUserId(user.Id);
        return Ok();
    }

    [HttpPost]
    public async Task<IActionResult> PublishDraft()
    {
        throw new NotImplementedException();
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