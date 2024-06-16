using AutoMapper;
using Domain.Entities;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Web.Dtos;
using Web.Dtos.Request;
using Web.Services;
using Web.Services.Validators;

namespace Web.Controllers;

[Authorize]
public class EventAdminController : Controller
{
    private readonly IMapper mapper;
    private readonly IUserFilesService userFilesService;
    private readonly IUserHelper userHelper;
    private readonly IDraftEventsService draftEventsService;
    private readonly IDraftQuestionsService draftQuestionsService;
    private readonly IDraftEventPublisherService draftEventPublisherService;
    private readonly IDraftEventValidator draftEventValidator;
    private readonly IDraftTicketsService draftTicketsService;

    public EventAdminController(
        IUserHelper userHelper,
        IDraftEventsService draftEventsService,
        IDraftQuestionsService draftQuestionsService,
        IMapper mapper,
        IUserFilesService userFilesService,
        IDraftEventPublisherService draftEventPublisherService,
        IDraftEventValidator draftEventValidator,
        IDraftTicketsService draftTicketsService)
    {
        this.userHelper = userHelper;
        this.draftEventsService = draftEventsService;
        this.draftQuestionsService = draftQuestionsService;
        this.mapper = mapper;
        this.userFilesService = userFilesService;
        this.draftEventPublisherService = draftEventPublisherService;
        this.draftEventValidator = draftEventValidator;
        this.draftTicketsService = draftTicketsService;
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

        return Ok(mapper.Map<DraftEventCoverDto>(draft));
    }

    [HttpPost("[controller]/draftCover")]
    public async Task<IActionResult> DraftCover([FromBody] DraftEventCoverDto draftEventDto)
    {
        if (!ModelState.IsValid)
            return BadRequest();

        var userId = userHelper.UserId;
        var existsDraft = await draftEventsService.FindDraftByUserIdAsync(userId);
        if (existsDraft is null)
            return NotFound();

        draftEventDto.CoverImageId = existsDraft.CoverImageId;
        var newDraftEventCover = mapper.Map(draftEventDto, existsDraft);

        await draftEventsService.UpdateDraftAsync(newDraftEventCover);
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

        var fileStream = await userFilesService.GetContent(userFile);
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

    [HttpGet("[controller]/tickets")]
    public async Task<IActionResult> Tickets()
    {
        if (!ModelState.IsValid)
            return BadRequest();

        var userId = userHelper.UserId;
        var srcDraft = await draftEventsService.FindDraftByUserIdAsync(userId);
        if (srcDraft is null)
            return NotFound();

        var tickets = await draftTicketsService.GetDraftTicketsByEventIdAsync(srcDraft.Id);
        return Ok(tickets);
    }

    [HttpPost("[controller]/tickets")]
    public async Task<IActionResult> Tickets([FromForm] List<CreateTicketDto> tickets)
    {
        if (!ModelState.IsValid || !tickets.Any())
            return BadRequest();

        var userId = userHelper.UserId;
        var srcDraft = await draftEventsService.FindDraftByUserIdAsync(userId);
        if (srcDraft is null)
            return NotFound();

        foreach (var ticket in tickets)
        {
            var savedFile = await userFilesService.Save(ticket.CoverImage, true);
            ticket.CoverImageId = savedFile.Id;
        }

        var newDraftTickets = mapper.Map<DraftTicket[]>(tickets);
        await draftTicketsService.SetDraftTicketsAsync(newDraftTickets, srcDraft.Id);
        return Ok();
    }

    [HttpGet("[controller]/ticketImage/{ticketId:int}")]
    public async Task<IActionResult> TicketImage([FromRoute] int ticketId)
    {
        var userId = userHelper.UserId;
        var srcDraft = await draftEventsService.FindDraftByUserIdAsync(userId);
        if (srcDraft is null)
            return NotFound();

        var foundTicket = await draftTicketsService.GetDraftTicketAsync(ticketId);
        if (foundTicket.IsFailed || foundTicket.Value.DraftEventId != srcDraft.Id)
            return NotFound();

        var imageFile = await userFilesService.TryGet(foundTicket.Value.CoverImageId);
        if (imageFile is null)
            return NotFound();

        var fileStream = await userFilesService.GetContent(imageFile);
        return File(fileStream, "APPLICATION/octet-stream");
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

    [HttpPost("[controller]/publishDraft")]
    public async Task<IActionResult> PublishDraft([FromBody] CreateTicketDto[] tickets)
    {
        if (!ModelState.IsValid || !tickets.Any())
            return BadRequest();

        var userId = userHelper.UserId;
        var srcDraft = await draftEventsService.FindDraftByUserIdAsync(userId);
        if (srcDraft is null)
            return NotFound();

        srcDraft.To = srcDraft.From; // TODO DELETE
        if (!draftEventValidator.IsValid(srcDraft))
            return BadRequest();

        var srcDraftQuestions = await draftQuestionsService.GetDraftQuestionsByDraftEventIdAsync(srcDraft.Id);

        var dstEvent = mapper.Map<Event>(srcDraft);
        var dstQuestions = mapper.Map<Question[]>(srcDraftQuestions);
        var dstTickets = mapper.Map<Ticket[]>(tickets);

        var newEvent = await draftEventPublisherService.Publish(srcDraft, dstEvent, dstQuestions, dstTickets);

        var url = Url.Action("preview", "home", new {id = newEvent});
        return Ok(url);
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