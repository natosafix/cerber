using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using Cerber.Models;

namespace Cerber.Controllers;

public class HomeController : Controller
{
    private readonly ILogger<HomeController> _logger;

    public HomeController(ILogger<HomeController> logger)
    {
        _logger = logger;
    }

    [HttpGet("/[controller]/index")]
    public IActionResult Index()
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