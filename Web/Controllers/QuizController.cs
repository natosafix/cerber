using Microsoft.AspNetCore.Mvc;

namespace Web.Controllers;

public class QuizController : Controller
{
    [HttpGet("[controller]/solve/{id}")]
    public async Task<IActionResult> QuizSolve([FromRoute] int id)
    {
        return View();
    }

    [HttpGet("[controller]/congrats")]
    public async Task<IActionResult> Congrats([FromQuery] int eventId)
    {
        return View();
    }
}