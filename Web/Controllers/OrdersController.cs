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
public class OrdersController : Controller
{
    private readonly IOrdersService ordersService;
    private readonly IMapper mapper;
    
    public OrdersController(IOrdersService ordersService, IMapper mapper)
    {
        this.ordersService = ordersService;
        this.mapper = mapper;
    }

    [HttpGet("")]
    public async Task<IActionResult> Get([FromQuery] int eventId)
    {
        var order = await ordersService.Get(eventId);
        return Ok(mapper.Map<List<OrderResponseDto>>(order));
    }

    [HttpPost("")]
    public async Task<IActionResult> Create([FromBody] CreateOrderDto createOrderDto)
    {
        if (!ModelState.IsValid)
            return BadRequest(ModelState);
        
        var order = await ordersService.Create(mapper.Map<Order>(createOrderDto));
        return Ok(mapper.Map<OrderResponseDto>(order));
    }
}