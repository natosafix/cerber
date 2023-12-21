using Microsoft.AspNetCore.Authorization;

namespace Web.Requirements;

public class MustInspectOrderRequirement : IAuthorizationRequirement
{
    public MustInspectOrderRequirement()
    {
    }
}