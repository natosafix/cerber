using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using Domain.Entities;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using Web.Models;

namespace Web.Controllers;

public class AuthController : Controller
{
    private readonly ILogger<AuthController> logger;
    private readonly UserManager<User> userManager;
    private readonly RoleManager<IdentityRole> roleManager;
    private readonly IConfiguration config;

    public AuthController(ILogger<AuthController> logger, UserManager<User> userManager, RoleManager<IdentityRole> roleManager, IConfiguration config)
    {
        this.logger = logger;
        this.userManager = userManager;
        this.roleManager = roleManager;
        this.config = config;
    }

    [HttpPost("/[controller]/register")]
    public async Task<IActionResult> Register([FromBody] RegisterModel model)
    {
        if (!ModelState.IsValid)
            return BadRequest(ModelState);
        
        var userExists = await userManager.FindByNameAsync(model.Username);
        if (userExists != null)
            return BadRequest("User already exists");

        User user = new()
        {
            Email = model.Email,
            SecurityStamp = Guid.NewGuid().ToString(),
            UserName = model.Username
        };
        var result = await userManager.CreateAsync(user, model.Password);
        if (!result.Succeeded)
            return StatusCode(StatusCodes.Status500InternalServerError, "User creation failed! Please check user details and try again.");

        return Ok("User created successfully!");

    }
    
    [HttpPost("/[controller]/login")]
    public async Task<IActionResult> Login([FromBody] LoginModel model)
    {
        if (!ModelState.IsValid)
            return BadRequest(ModelState);
        
        var user = await userManager.FindByNameAsync(model.Username);
        if (user != null && await userManager.CheckPasswordAsync(user, model.Password))
        {
            var userRoles = await userManager.GetRolesAsync(user);

            var authClaims = new List<Claim>
            {
                new(ClaimTypes.Name, user.UserName),
                new(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
            };
            authClaims.AddRange(userRoles.Select(userRole => new Claim(ClaimTypes.Role, userRole)));

            var token = GetToken(authClaims);
            var tokenString = new JwtSecurityTokenHandler().WriteToken(token);
            
            Response.Cookies.Append(config["JWT:CookieName"]!, tokenString, new CookieOptions {HttpOnly = true});
            return Ok(new
            {
                token = tokenString,
                expiration = token.ValidTo
            });
        }
        return Unauthorized();
    }
    
    private JwtSecurityToken GetToken(List<Claim> authClaims)
    {
        var authSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(config["JWT:Secret"]!));

        var token = new JwtSecurityToken(
            issuer: config["JWT:ValidIssuer"],
            audience: config["JWT:ValidAudience"],
            expires: DateTime.Now.AddDays(3),
            claims: authClaims,
            signingCredentials: new SigningCredentials(authSigningKey, SecurityAlgorithms.HmacSha256)
        );

        return token;
    }
}