using Microsoft.AspNetCore.Authorization;
using Web.Extensions;
using Web.Services;

namespace Web.Requirements;

public class MustInspectOrderHandler : AuthorizationHandler<MustInspectOrderRequirement>
{
    private readonly IUserHelper userHelper;
    private readonly IHttpContextAccessor httpContextAccessor;
    private readonly IAuthService authService;
    private readonly IOrdersService ordersService;

    public MustInspectOrderHandler(IUserHelper userHelper, IHttpContextAccessor httpContextAccessor, IAuthService authService, IOrdersService ordersService)
    {
        this.userHelper = userHelper;
        this.httpContextAccessor = httpContextAccessor;
        this.authService = authService;
        this.ordersService = ordersService;
    }

    protected override async Task HandleRequirementAsync(
        AuthorizationHandlerContext context, MustInspectOrderRequirement requirement)
    {
        var orderId = httpContextAccessor.HttpContext.GetCustomer();

        if (orderId is null)
        {
            context.Fail();
            return;
        }

        var order = await ordersService.Get(orderId.Value);
        if (await authService.IsInspector(userHelper.UserId, order.Ticket.EventId))
            context.Succeed(requirement);
        else 
            context.Fail();
    }
}