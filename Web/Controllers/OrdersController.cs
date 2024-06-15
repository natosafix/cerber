using AutoMapper;
using Domain.Entities;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Robokassa;
using Robokassa.Enums;
using Robokassa.Exceptions;
using Robokassa.Models;
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
    private readonly IRobokassaService robokassaService;
    private readonly IUserHelper userHelper;
    private readonly IMapper mapper;
    
    public OrdersController(IOrdersService ordersService, IMapper mapper, ITicketsService ticketsService, IAuthService authService, IUserHelper userHelper, IRobokassaService robokassaService)
    {
        this.ordersService = ordersService;
        this.mapper = mapper;
        this.ticketsService = ticketsService;
        this.authService = authService;
        this.userHelper = userHelper;
        this.robokassaService = robokassaService;
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
        var receipt = new RobokassaReceiptRequest(
            SnoType.Patent,
            new List<ReceiptOrderItem>
            {
                new(order.Ticket.Name, 1, order.Ticket.Price, Tax.Vat110, PaymentMethod.FullPayment,
                    PaymentObject.Payment)
            });
        var customFields = new CustomShpParameters();
        customFields.Add("customer", order.Customer.ToString());
        
        return Ok(robokassaService.GenerateAuthLink(receipt.TotalPrice, order.Ticket.Name,  receipt, customFields).Link);
    }
    
    [AllowAnonymous]
    [HttpPost("paymentResult")]
    public async Task<IActionResult> ProcessPaymentResult(
        [FromServices] IRobokassaPaymentValidator robokassaPaymentValidator,
        [FromForm] RobokassaCallbackRequest request,
        [FromForm(Name = "Shp_customer")] string customer)
    {
        try
        {
            robokassaPaymentValidator.CheckResult(
                request.OutSum,
                request.InvId,
                request.SignatureValue,
                new KeyValuePair<string, string>("Shp_customer", customer)
            );

            await ordersService.SetPaid(Guid.Parse(customer));
        }
        catch (RobokassaBaseException)
        {
            //TODO: _log.Error(e.Message);
        }

        return Content($"OK{request.InvId}");
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
        
        order.Paid = true;
        var createdOrder = await ordersService.Create(order);
        return Ok(createdOrder.Customer.ToString());
    }
    
    [Authorize("MustInspectOrder")]    
    [HttpPut("{customer}/paid")]
    public async Task<IActionResult> SetPaid([FromRoute] Guid customer)
    {
        await ordersService.SetPaid(customer);
        return Ok();
    }
}