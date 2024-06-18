using Microsoft.AspNetCore.Mvc;

namespace Web.Controllers;

public class QuizController : Controller
{
    [HttpGet("[controller]/solve/{id}")]
    public async Task<IActionResult> QuizSolve([FromRoute] int id)
    {
        return View();
    }

    [HttpGet("[controller]/congrats/")]
    public async Task<IActionResult> Congrats([FromQuery(Name = "Shp_eventId")] int eventId)
    {
        return View();
    }

    [HttpGet("[controller]/fail")]
    public async Task<IActionResult> Failed([FromQuery(Name = "Shp_customer")] Guid shopCustomer)
    {
        return View();
    }
}