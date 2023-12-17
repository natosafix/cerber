using AutoMapper;
using Domain.Entities;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Web.Models;
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
        return Ok(await ordersService.Get(eventId));
    }

    [HttpPost("")]
    [Produces("application/json")]
    public async Task<IActionResult> Create([FromBody] CreateOrderDto createOrderDto)
    {
        var order = await ordersService.Create(mapper.Map<Order>(createOrderDto));
        return Ok(order);
    }
}