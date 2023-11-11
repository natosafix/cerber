using Microsoft.AspNetCore.Mvc;

namespace Web.Controllers;

public class EventAdminController : Controller
{
    [HttpGet("/[controller]/index")]
    public ViewResult Index()
    {
        return View();
    }
}