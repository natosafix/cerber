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
    public async Task<IActionResult> Draft()
    {
        return View("index");
    }

    [HttpGet("[controller]/draftCover")]
    public async Task<IActionResult> DraftCover()
    {
        var userId = userHelper.UserId;
        var draft = await draftEventService.FindDraftByUserIdAsync(userId);
        return Ok(draft);
    }

    [HttpPost("[controller]/draftCover")]
    public async Task<IActionResult> DraftCover([FromBody] DraftEvent draftEvent)
    {
        var userId = userHelper.UserId;
        if (draftEvent.OwnerId != userId)
            return BadRequest();
        await draftEventService.UpdateDraft(draftEvent);
        return Ok();
    }

    [HttpPost("createDraft")]
    public async Task<IActionResult> CreateDraft()
    {
        var userId = userHelper.UserId;

        var draft = await draftEventService.FindDraftByUserIdAsync(userId);
        if (draft != null)
            return BadRequest("User already has a draft");

        draft = await draftEventService.CreateDraftAsync(userId);

        return Ok(draft);
    }
}