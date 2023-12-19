using Microsoft.AspNetCore.Authorization;

namespace Web.Requirements;

public class MustInspectEventRequirement : IAuthorizationRequirement
{
    public MustInspectEventRequirement()
    {
    }
}