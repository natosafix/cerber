using Microsoft.AspNetCore.Authorization;

namespace Web.Requirements;

public class MustOwnEventRequirement : IAuthorizationRequirement
{
    public MustOwnEventRequirement()
    {
    }
}