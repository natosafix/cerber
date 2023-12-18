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

    public QuestionsController(IMapper mapper, IQuestionsService questionsService)
    {
        this.mapper = mapper;
        this.questionsService = questionsService;
    }

    [HttpGet("")]
    public async Task<IActionResult> Get([FromQuery] int eventId)
    {
        var question = await questionsService.GetByEvent(eventId);
        return Ok(mapper.Map<List<QuestionResponseDto>>(question));
    }
    
    [HttpGet("{id}")]
    public async Task<IActionResult> GetByEvent([FromRoute] int id)
    {
        var question = await questionsService.Get(id);
        return Ok(mapper.Map<QuestionResponseDto>(question));
    }
    
    [HttpPost("")]
    public async Task<IActionResult> Create([FromBody] CreateQuestionDto createQuestionDto)
    {
        if (!ModelState.IsValid)
            return BadRequest(ModelState);

        var question = await questionsService.Create(mapper.Map<Question>(createQuestionDto));
        return Ok(mapper.Map<QuestionResponseDto>(question));
    }
}