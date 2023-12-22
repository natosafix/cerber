using Domain.Entities;
using Domain.Infrastructure;
using Web.Persistence.Repositories;

namespace Web.Services.Implementations;

public class OrdersService : IOrdersService
{
    private readonly IOrdersRepository ordersRepository;
    private readonly IMailService mailService;
    private readonly IQrCodeService qrCodeService;
    
    public OrdersService(IOrdersRepository ordersRepository, IMailService mailService, IQrCodeService qrCodeService)
    {
        this.ordersRepository = ordersRepository;
        this.mailService = mailService;
        this.qrCodeService = qrCodeService;
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
        
        var qrCode = qrCodeService.Create($"ticket.png", order.Customer.ToString());
        await mailService.SendWithImageAttachments(
            "name",
            "address",
            "Tickets",
            "Спасибо за заказ. Ваши билеты во вложениях.",
            new List<ImageInfo> {qrCode});
        
        return order;
    }
}