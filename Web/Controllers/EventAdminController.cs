using Domain.Entities;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Web.Services;

namespace Web.Controllers;

[Authorize]
public class EventAdminController : Controller
{
    private readonly IUserHelper userHelper;
    private readonly IDraftEventService draftEventService;

    public EventAdminController(IUserHelper userHelper, IDraftEventService draftEventService)
    {
        this.userHelper = userHelper;
        this.draftEventService = draftEventService;
    }

    [HttpGet("[controller]/draft")]
    public async Task<IActionResult> Draft([FromQuery] string id)
    {
        return View("index");
    }

    [HttpGet("[controller]/draftCover")]
    public async Task<IActionResult> DraftCover([FromQuery] string id)
    {
        var draft = await draftEventService.FindDraftByUserIdAsync(id);
        return Ok(draft);
    }

    [HttpPost("[controller]/draftCover")]
    public async Task<IActionResult> DraftCover([FromQuery] string id, [FromBody] DraftEvent draftEvent)
    {
        var draft = await draftEventService.FindDraftByUserIdAsync(id);
        return Ok(draft);
    }

    [HttpPost("createDraft")]
    public async Task<IActionResult> CreateDraft()
    {
        var user = await userHelper.GetUser();

        var draft = await draftEventService.FindDraftByUserIdAsync(user!.Id);
        if (draft != null)
            return BadRequest("User already has a draft");

        draft = await draftEventService.CreateDraftAsync(user.Id);

        return Ok(draft);
    }
}