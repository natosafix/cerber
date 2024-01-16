using System.Diagnostics;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Web.Dtos.Response;

namespace Web.Controllers;

public class HomeController : Controller
{
    private readonly ILogger<HomeController> logger;

    public HomeController(ILogger<HomeController> logger)
    {
        this.logger = logger;
    }

    [Authorize]
    [HttpGet("/[controller]/index")]
    public IActionResult Index()
    {
        return View();
    }
    
    [HttpGet("/[controller]/register")]
    public IActionResult Register()
    {
        return View();
    }
    
    [HttpGet("/[controller]/login")]
    public IActionResult Login()
    {
        return View();
    }
    
    [HttpGet("/[controller]/preview/{id}")]
    public IActionResult Preview()
    {
        return View();
    }

    [HttpGet("/error")]
    public IActionResult Error([FromRoute] int statusCode)
    {
        return View();
    }

    [HttpGet("/[controller]/privacy")]
    public IActionResult Privacy()
    {
        return View();
    }

    [HttpGet("/[controller]/error")]
    [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
    public IActionResult Error()
    {
        return View(new ErrorViewModel {RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier});
    }
}