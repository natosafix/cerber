using AutoMapper;
using Domain.Entities;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Web.Dtos.Request;
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

    [HttpPost("")]
    public async Task<IActionResult> Create([FromBody] CreateQuestionDto createQuestionDto)
    {
        if (!ModelState.IsValid)
            return BadRequest(ModelState);
        
        return Ok(await questionsService.Create(mapper.Map<Question>(createQuestionDto)));
    }
}