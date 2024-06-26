﻿using AutoMapper;
using Domain.Entities;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Robokassa;
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
    [HttpGet("{customer:guid}")]
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
        var ticket = await ticketsService.Get(order.TicketId);
        
        var paymentLink = robokassaService.GeneratePaymentLink(
            ticket.Price,
            ticket.Name,
            GetCustomShpParameters(order));
        
        return Ok(paymentLink);
    }
    
    [AllowAnonymous]
    [HttpGet("{customer:guid}/retryPayment")]
    public async Task<IActionResult> RetryPayment([FromRoute] Guid customer)
    {
        var order = await ordersService.Get(customer);
        var ticket = await ticketsService.Get(order.TicketId);

        var paymentLink = robokassaService.GeneratePaymentLink(
            ticket.Price,
            ticket.Name,
            GetCustomShpParameters(order));
        
        return Ok(paymentLink);
    }
    
    [AllowAnonymous]
    [HttpPost("paymentResult")]
    public async Task<IActionResult> ProcessPaymentResult(
        [FromServices] IRobokassaPaymentValidator robokassaPaymentValidator,
        [FromForm] RobokassaCallbackRequest request,
        [FromForm(Name = "Shp_customer")] string customer,
        [FromForm(Name = "Shp_eventId")] string eventId)
    {
        try
        {
            robokassaPaymentValidator.CheckResult(
                request.OutSum,
                request.InvId,
                request.SignatureValue,
                new KeyValuePair<string, string>("Shp_customer", customer),
                new KeyValuePair<string, string>("Shp_eventId", eventId)
            );

            await ordersService.SetPaid(Guid.Parse(customer));
        }
        catch (RobokassaBaseException e)
        {
            Console.WriteLine("Robokassa payment result handling error occured:");
            Console.Write(e.Message);
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

        var inspector = await userHelper.GetUser();
        order.InspectorName = inspector!.UserName;
        
        var createdOrder = await ordersService.Create(order);
        await ordersService.SetPaid(createdOrder.Customer);
        return Ok(createdOrder.Customer.ToString());
    }
    
    [Authorize("MustInspectOrder")]    
    [HttpPut("{customer:guid}/paid")]
    public async Task<IActionResult> SetPaid([FromRoute] Guid customer)
    {
        await ordersService.SetPaid(customer);
        return Ok();
    }

    private static CustomShpParameters GetCustomShpParameters(Order order)
    {
        var customFields = new CustomShpParameters();
        customFields.Add("customer", order.Customer.ToString());
        customFields.Add("eventId", order.Ticket.EventId.ToString());
        return customFields;
    }
}