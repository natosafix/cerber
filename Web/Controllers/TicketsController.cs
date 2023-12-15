using AutoMapper;
using Domain.Entities;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Web.Models;
using Web.Services;

namespace Web.Controllers;

[Authorize]
[Route("[controller]")]
public class TicketsController : Controller
{
    private readonly ITicketsService ticketsService;
    private readonly IMapper mapper;
    
    public TicketsController(ITicketsService ticketsService, IMapper mapper)
    {
        this.ticketsService = ticketsService;
        this.mapper = mapper;
    }

    [HttpPost("")]
    [Produces("application/json")]
    public async Task<IActionResult> Create([FromBody] CreateTicketDto createTicketDto)
    {
        var ticket = await ticketsService.Create(mapper.Map<Ticket>(createTicketDto));
        return Ok(ticket);
    }
}