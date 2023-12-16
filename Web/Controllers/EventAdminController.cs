using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Web.Controllers;

[Authorize]
public class EventAdminController : Controller
{
    [HttpGet("/[controller]/index")]
    public ViewResult Index()
    {
        return View();
    }
}