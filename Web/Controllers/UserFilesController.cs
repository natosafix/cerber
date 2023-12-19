using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Web.Services;

namespace Web.Controllers;

[Authorize]
[Route("files")]
public class UserFilesController : Controller
{
    private readonly IUserFilesService userFilesService;
    
    public UserFilesController(IUserFilesService userFilesService)
    {
        this.userFilesService = userFilesService;
    }
    
    [HttpGet("{id}")]
    public async Task<IActionResult> Get([FromRoute] int id)
    {
        return Ok(await userFilesService.Get(id));
    }
    
    [HttpGet("{id}/download")]
    public async Task<IActionResult> Download([FromRoute] int id)
    {
        var userFile = await userFilesService.Get(id);
        var bytes = await userFilesService.GetContent(userFile);
        return File(bytes, "APPLICATION/octet-stream", userFile.Name);
    }

    [HttpPost("")]
    public async Task<IActionResult> Upload(IFormFile file)
    {
        return Ok(await userFilesService.Save(file));
    }
}