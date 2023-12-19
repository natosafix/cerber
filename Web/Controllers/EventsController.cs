﻿using AutoMapper;
using Domain.Entities;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Web.Dtos.Request;
using Web.Dtos.Response;
using Web.Services;

namespace Web.Controllers;

[Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
[Route("[controller]")]
public class EventsController : Controller
{
    private readonly IMapper mapper;
    private readonly IEventsService eventsService;
    private readonly IUserHelper userHelper;
    private readonly IDraftEventService draftEventService;

    public EventsController(IMapper mapper, IEventsService eventsService, IUserHelper userHelper,
        IDraftEventService draftEventService)
    {
        this.mapper = mapper;
        this.eventsService = eventsService;
        this.userHelper = userHelper;
        this.draftEventService = draftEventService;
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
        return Ok(await eventsService.Create(mapper.Map<Event>(eventResponse)));
    }

    [HttpGet("draft")]
    public async Task<IActionResult> Draft()
    {
        var user = await userHelper.GetUser();
        var draft = await draftEventService.FindDraftByUserIdAsync(user!.Id);
        return Ok(draft);
    }

    [HttpPost("createDraft")]
    public async Task<IActionResult> CreateDraft()
    {
        var user = await userHelper.GetUser();

        var draft = await draftEventService.FindDraftByUserIdAsync(user!.Id);
        if (draft != null)
            return BadRequest("User already has a draft");

        draft = await draftEventService.CreateDraftAsync(user.Id);

        return Ok(draft);
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
}