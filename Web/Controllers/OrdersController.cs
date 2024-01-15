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
    private readonly ITicketsService ticketsService;
    private readonly IAuthService authService;
    private readonly IUserHelper userHelper;
    private readonly IMapper mapper;
    
    public OrdersController(IOrdersService ordersService, IMapper mapper, ITicketsService ticketsService, IAuthService authService, IUserHelper userHelper)
    {
        this.ordersService = ordersService;
        this.mapper = mapper;
        this.ticketsService = ticketsService;
        this.authService = authService;
        this.userHelper = userHelper;
    }

    [Authorize("MustInspectOrder")]    
    [HttpGet("{customer}")]
    public async Task<IActionResult> Get([FromRoute] Guid customer)
    {
        var order = await ordersService.Get(customer);
        return Ok(mapper.Map<OrderResponseDto>(order));
    }
    
    [Authorize("MustInspectEvent")]    
    [HttpGet("")]
    public async Task<IActionResult> GetByEvent([FromQuery] int eventId)
    {
        var order = await ordersService.GetByEvent(eventId);
        return Ok(mapper.Map<List<OrderResponseDto>>(order));
    }

    [AllowAnonymous]
    [HttpPost("")]
    public async Task<IActionResult> Create([FromBody] CreateOrderDto createOrderDto)
    {
        if (!ModelState.IsValid)
            return BadRequest(ModelState);
        
        var order = await ordersService.Create(mapper.Map<Order>(createOrderDto));
        return Ok(mapper.Map<OrderResponseDto>(order));
    }
    
    [HttpPost("byInspector")]
    public async Task<IActionResult> CreateByInspector([FromBody] CreateOrderDto createOrderDto)
    {
        if (!ModelState.IsValid)
            return BadRequest(ModelState);

        var order = mapper.Map<Order>(createOrderDto);
        var ticket = await ticketsService.Get(order.TicketId);
        if (!await authService.IsInspector(userHelper.UserId, ticket.EventId))
            return StatusCode(403);
        
        var createdOrder = await ordersService.Create(order);
        return Ok(createdOrder.Customer.ToString());
    }
}