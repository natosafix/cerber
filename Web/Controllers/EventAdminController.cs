using AutoMapper;
using Domain.Entities;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Web.Dtos;
using Web.Services;

namespace Web.Controllers;

[Authorize]
public class EventAdminController : Controller
{
    private readonly IMapper mapper;
    private readonly IUserHelper userHelper;
    private readonly IDraftEventsService draftEventsService;
    private readonly IDraftQuestionsService draftQuestionsService;

    public EventAdminController(IUserHelper userHelper, IDraftEventsService draftEventsService,
        IDraftQuestionsService draftQuestionsService, IMapper mapper)
    {
        this.userHelper = userHelper;
        this.draftEventsService = draftEventsService;
        this.draftQuestionsService = draftQuestionsService;
        this.mapper = mapper;
    }

    [HttpGet("[controller]/draft")]
    public Task<IActionResult> Draft()
    {
        return Task.FromResult<IActionResult>(View("index"));
    }

    [HttpGet("[controller]/draftCover")]
    public async Task<IActionResult> DraftCover()
    {
        var userId = userHelper.UserId;
        var draft = await draftEventsService.FindDraftByUserIdAsync(userId);
        return Ok(draft);
    }

    [HttpPost("[controller]/draftCover")]
    public async Task<IActionResult> DraftCover([FromBody] DraftEvent draftEvent)
    {
        var userId = userHelper.UserId;
        if (draftEvent.OwnerId != userId)
            return BadRequest();
        await draftEventsService.UpdateDraftAsync(draftEvent);
        return Ok();
    }

    [HttpGet("[controller]/questions")]
    public async Task<IActionResult> Questions()
    {
        var userId = userHelper.UserId;
        var draftEvent = await draftEventsService.FindDraftByUserIdAsync(userId);
        if (draftEvent is null)
            return BadRequest();

        var questions = await draftQuestionsService.GetDraftQuestionsByDraftEventIdAsync(draftEvent.Id);
        var result = mapper.Map<DraftQuestionDto[]>(questions);
        return Ok(result);
    }

    [HttpPost("[controller]/questions")]
    public async Task<IActionResult> Questions([FromBody] DraftQuestionDto[] draftQuestions)
    {
        if (!ModelState.IsValid)
            return BadRequest(ModelState.ToList());

        var userId = userHelper.UserId;
        var draftEvent = await draftEventsService.FindDraftByUserIdAsync(userId);
        if (draftEvent is null)
            return BadRequest();

        var questions = mapper.Map<DraftQuestion[]>(draftQuestions);
        await draftQuestionsService.SetDraftQuestionsAsync(questions, draftEvent.Id);
        return Ok();
    }

    [HttpPost("createDraft")]
    public async Task<IActionResult> CreateDraft()
    {
        var userId = userHelper.UserId;

        var draft = await draftEventsService.FindDraftByUserIdAsync(userId);
        if (draft != null)
            return BadRequest("User already has a draft");

        draft = await draftEventsService.CreateDraftAsync(userId);

        return Ok(draft);
    }
}