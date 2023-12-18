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
    
    public TicketsController(ITicketsService ticketsService, IMapper mapper)
    {
        this.ticketsService = ticketsService;
        this.mapper = mapper;
    }

    [HttpPost("")]
    public async Task<IActionResult> Create([FromBody] CreateTicketDto createTicketDto)
    {
        if (!ModelState.IsValid)
            return BadRequest(ModelState);
        
        var ticket = await ticketsService.Create(mapper.Map<Ticket>(createTicketDto));
        return Ok(mapper.Map<TicketResponseDto>(ticket));
    }
}