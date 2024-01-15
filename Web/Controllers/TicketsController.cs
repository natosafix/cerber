using AutoMapper;
using Domain.Entities;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Web.Dtos.Request;
using Web.Dtos.Response;
using Web.Services;

namespace Web.Controllers;

[Authorize]
[Route("[controller]")]
public class TicketsController : Controller
{
    private readonly ITicketsService ticketsService;
    private readonly IMapper mapper;
    private readonly IAuthService authService;
    private readonly IUserHelper userHelper;
    
    public TicketsController(ITicketsService ticketsService, IMapper mapper, IAuthService authService, IUserHelper userHelper)
    {
        this.ticketsService = ticketsService;
        this.mapper = mapper;
        this.authService = authService;
        this.userHelper = userHelper;
    }
    
    [Authorize("MustInspectEvent")]    
    [HttpGet("")]
    public async Task<IActionResult> Get([FromQuery] int eventId)
    {
        var tickets = await ticketsService.GetByEvent(eventId);
        return Ok(mapper.Map<TicketResponseDto>(tickets));
    }

    [HttpPost("")]
    public async Task<IActionResult> Create([FromBody] CreateTicketDto[] createTicketDto)
    {
        if (!ModelState.IsValid)
            return BadRequest(ModelState);
        
        var ticket = mapper.Map<Ticket>(createTicketDto);
        if (!await authService.IsOwner(userHelper.UserId, ticket.EventId))
            return StatusCode(403);
        
        var ticketCreated = await ticketsService.Create(ticket);
        return Ok(mapper.Map<TicketResponseDto>(ticketCreated));
    }
}