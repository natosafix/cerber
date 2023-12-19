using AutoMapper;
using Domain.Entities;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Web.Dtos.Request;
using Web.Dtos.Response;
using Web.Services;

namespace Web.Controllers;

[Authorize]
[Route("[controller]")]
public class QuestionsController : Controller
{
    private readonly IMapper mapper;
    private readonly IQuestionsService questionsService;
    private readonly IAuthService authService;
    private readonly IUserHelper userHelper;

    public QuestionsController(IMapper mapper, IQuestionsService questionsService, IAuthService authService, IUserHelper userHelper)
    {
        this.mapper = mapper;
        this.questionsService = questionsService;
        this.authService = authService;
        this.userHelper = userHelper;
    }

    [AllowAnonymous]
    [HttpGet("{id}")]
    public async Task<IActionResult> Get([FromRoute] int id)
    {
        var question = await questionsService.Get(id);
        return Ok(mapper.Map<QuestionResponseDto>(question));
    }
    
    [AllowAnonymous]
    [HttpGet("")]
    public async Task<IActionResult> GetByEvent([FromQuery] int eventId)
    {
        var question = await questionsService.GetByEvent(eventId);
        return Ok(mapper.Map<List<QuestionResponseDto>>(question));
    }
    
    [HttpPost("")]
    public async Task<IActionResult> Create([FromBody] CreateQuestionDto createQuestionDto)
    {
        if (!ModelState.IsValid)
            return BadRequest(ModelState);

        var question = mapper.Map<Question>(createQuestionDto);
        if (!await authService.IsOwner(userHelper.UserId, question.EventId))
            return StatusCode(403);

        var questionCreated = await questionsService.Create(question);
        return Ok(mapper.Map<QuestionResponseDto>(questionCreated));
    }
}