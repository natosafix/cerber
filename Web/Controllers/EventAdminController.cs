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
    private readonly IUserFilesService userFilesService;
    private readonly IUserHelper userHelper;
    private readonly IDraftEventsService draftEventsService;
    private readonly IDraftQuestionsService draftQuestionsService;

    public EventAdminController(
        IUserHelper userHelper,
        IDraftEventsService draftEventsService,
        IDraftQuestionsService draftQuestionsService,
        IMapper mapper,
        IUserFilesService userFilesService)
    {
        this.userHelper = userHelper;
        this.draftEventsService = draftEventsService;
        this.draftQuestionsService = draftQuestionsService;
        this.mapper = mapper;
        this.userFilesService = userFilesService;
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
        if (draft is null)
            return NotFound();

        return Ok(draft);
    }

    [HttpPost("[controller]/draftCover")]
    public async Task<IActionResult> DraftCover([FromBody] DraftEvent draftEvent)
    {
        var userId = userHelper.UserId;
        if (draftEvent.OwnerId != userId)
            return NotFound();
        
        var existsDraft = await draftEventsService.FindDraftByUserIdAsync(userId);
        if (existsDraft is not null)
            draftEvent.CoverImageId = existsDraft.CoverImageId;

        await draftEventsService.UpdateDraftAsync(draftEvent);
        return Ok();
    }

    [HttpGet("[controller]/questions")]
    public async Task<IActionResult> Questions()
    {
        var userId = userHelper.UserId;
        var draftEvent = await draftEventsService.FindDraftByUserIdAsync(userId);
        if (draftEvent is null)
            return NotFound();

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
            return NotFound();

        var questions = mapper.Map<DraftQuestion[]>(draftQuestions);
        await draftQuestionsService.SetDraftQuestionsAsync(questions, draftEvent.Id);
        return Ok();
    }

    [HttpGet("[controller]/coverImage")]
    public async Task<IActionResult> GetCoverImage()
    {
        var userId = userHelper.UserId;
        var draftEvent = await draftEventsService.FindDraftByUserIdAsync(userId);
        if (draftEvent?.CoverImageId is null)
            return NotFound();

        var userFile = await userFilesService.TryGet(draftEvent.CoverImageId.Value);
        if (userFile is null)
            return NotFound();

        var fileStream = userFilesService.GetContentStream(userFile);
        return File(fileStream, "APPLICATION/octet-stream");
    }

    [HttpPost("[controller]/coverImage")]
    public async Task<IActionResult> SetCoverImage(IFormFile file)
    {
        var userId = userHelper.UserId;
        var draftEvent = await draftEventsService.FindDraftByUserIdAsync(userId);
        if (draftEvent is null)
            return NotFound();

        var oldImgId = draftEvent.CoverImageId;

        var saved = await userFilesService.Save(file);
        draftEvent.CoverImageId = saved.Id;
        await draftEventsService.UpdateDraftAsync(draftEvent);

        if (oldImgId is not null)
        {
            var oldUserFile = await userFilesService.TryGet(oldImgId.Value);
            await userFilesService.Remove(oldUserFile!);
        }

        return Ok();
    }

    [HttpDelete("[controller]/coverImage")]
    public async Task<IActionResult> RemoveCoverImage()
    {
        var userId = userHelper.UserId;
        var draftEvent = await draftEventsService.FindDraftByUserIdAsync(userId);
        if (draftEvent?.CoverImageId == null)
            return NotFound();

        var userFile = await userFilesService.TryGet(draftEvent.CoverImageId.Value);
        if (userFile is null)
            return NotFound();

        draftEvent.CoverImageId = null;
        await draftEventsService.UpdateDraftAsync(draftEvent);

        await userFilesService.Remove(userFile!);

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