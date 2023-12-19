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
public class AnswersController : Controller
{
    private readonly IMapper mapper;
    private readonly IAnswersService answersService;
    private readonly IAuthService authService;
    private readonly IUserHelper userHelper;
    private readonly IQuestionsService questionsService;
    
    public AnswersController(IMapper mapper, IAnswersService answersService, IAuthService authService, IUserHelper userHelper, IQuestionsService questionsService)
    {
        this.mapper = mapper;
        this.answersService = answersService;
        this.authService = authService;
        this.userHelper = userHelper;
        this.questionsService = questionsService;
    }

    [HttpPost("")]
    public async Task<IActionResult> Create([FromBody] CreateAnswerDto createAnswerDto)
    {
        if (!ModelState.IsValid)
            return BadRequest(ModelState);
        
        var answer = mapper.Map<Answer>(createAnswerDto);
        var question = await questionsService.Get(answer.QuestionId);
        if (!await authService.IsInspector(userHelper.UserId, question.EventId))
            return StatusCode(403);
        
        var createdAnswer = await answersService.Create(answer);
        var answerResponse = mapper.Map<AnswerResponseDto>(createdAnswer);
        
        return Ok(answerResponse);
    }
}