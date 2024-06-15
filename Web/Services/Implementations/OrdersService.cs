﻿using Domain.Entities;
using Domain.Infrastructure;
using Newtonsoft.Json;
using Web.Persistence.Repositories;

namespace Web.Services.Implementations;

public class OrdersService : IOrdersService
{
    private readonly IOrdersRepository ordersRepository;
    private readonly IMailService mailService;
    private readonly IQrCodeService qrCodeService;
    private readonly IEventsService eventsService;
    private readonly IEncryptionService encryptionService;
    
    public OrdersService(IOrdersRepository ordersRepository, IMailService mailService, IQrCodeService qrCodeService, IEventsService eventsService, IEncryptionService encryptionService)
    {
        this.ordersRepository = ordersRepository;
        this.mailService = mailService;
        this.qrCodeService = qrCodeService;
        this.eventsService = eventsService;
        this.encryptionService = encryptionService;
    }

    public async Task<Order> Get(Guid customer)
    {
        return await ordersRepository.Get(customer) ?? throw new BadHttpRequestException($"Not found order with customer {customer}");
    }
    
    public Task<List<Order>> GetByEvent(int eventId)
    {
        return ordersRepository.GetByEvent(eventId);
    }

    public async Task<Order> Create(Order order)
    {
        order.Customer = Guid.NewGuid();
        order = await ordersRepository.Create(order);
        
        return order;
    }

    public async Task SetPaid(Guid customer)
    {
        await ordersRepository.SetPaid(customer);

        var order = await ordersRepository.Get(customer);
        if (order is null)
            return;
        
        var email = order.Answers
            .Where(answer => answer.Question.Title == "Email")
            .Select(answer => JsonConvert.DeserializeObject<string[]>(answer.Content)!.First())
            .First();
        
        var @event = await eventsService.GetByTicketId(order.TicketId);
        var cryptoKey = Convert.FromBase64String(@event.CryptoKey);
        var encryptedCustomer = encryptionService.EncryptString(order.Customer.ToString(), cryptoKey);
        
        var qrCode = qrCodeService.Create($"ticket.png", encryptedCustomer);
        await mailService.SendWithImageAttachments(
            "",
            email,
            "Tickets",
            "Спасибо за заказ. Ваши билеты во вложениях.",
            new List<ImageInfo> {qrCode});
    }
}