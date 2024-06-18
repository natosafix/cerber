using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Web.Services;

namespace Web.Controllers;

[Authorize]
[Route("[controller]")]
public class UsersController : Controller
{
    private readonly IUsersService usersService;
    
    public UsersController(IUsersService usersService)
    {
        this.usersService = usersService;
    }

    [HttpGet("")]
    public async Task<IActionResult> FindUser([FromQuery] string? username)
    {
        return Ok(await usersService.Find(username ?? string.Empty));
    }
}