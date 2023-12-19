using Microsoft.AspNetCore.Authorization;
using Web.Extensions;
using Web.Services;

namespace Web.Requirements;

public class MustOwnEventHandler : AuthorizationHandler<MustOwnEventRequirement>
{
    private readonly IUserHelper userHelper;
    private readonly IHttpContextAccessor httpContextAccessor;
    private readonly IAuthService authService;

    public MustOwnEventHandler(IUserHelper userHelper, IHttpContextAccessor httpContextAccessor, IAuthService authService)
    {
        this.userHelper = userHelper;
        this.httpContextAccessor = httpContextAccessor;
        this.authService = authService;
    }

    protected override async Task HandleRequirementAsync(
        AuthorizationHandlerContext context, MustOwnEventRequirement requirement)
    {
        var eventId = httpContextAccessor.HttpContext.GetEventId();
        
        if (eventId is null) {
            context.Fail();
            return;
        }
            
        if (await authService.IsOwner(userHelper.UserId, eventId.Value))
            context.Succeed(requirement);
        else 
            context.Fail();
    }
}