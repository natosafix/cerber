using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using Domain.Entities;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using Web.Dtos.Request;

namespace Web.Controllers;

public class AuthController : Controller
{
    private readonly UserManager<User> userManager;
    private readonly RoleManager<IdentityRole> roleManager;
    private readonly IConfiguration config;

    public AuthController(UserManager<User> userManager, RoleManager<IdentityRole> roleManager, IConfiguration config)
    {
        this.userManager = userManager;
        this.roleManager = roleManager;
        this.config = config;
    }

    [HttpPost("/[controller]/register")]
    public async Task<IActionResult> Register([FromBody] RegisterDto dto)
    {
        if (!ModelState.IsValid)
            return BadRequest(ModelState);
        
        var userExists = await userManager.FindByEmailAsync(dto.Email);
        if (userExists != null)
            return BadRequest("User already exists");

        User user = new()
        {
            Email = dto.Email,
            SecurityStamp = Guid.NewGuid().ToString(),
            UserName = dto.Username
        };
        var result = await userManager.CreateAsync(user, dto.Password);
        return result.Succeeded
            ? Ok("User created successfully!")
            : StatusCode(StatusCodes.Status500InternalServerError,
                "User creation failed! Please check user details and try again.");
    }
    
    [HttpPost("/[controller]/login")]
    public async Task<IActionResult> Login([FromBody] LoginDto dto)
    {
        if (!ModelState.IsValid)
            return BadRequest(ModelState);
        
        var user = await userManager.FindByEmailAsync(dto.Email);
        if (user != null && await userManager.CheckPasswordAsync(user, dto.Password))
        {
            var userRoles = await userManager.GetRolesAsync(user);

            var authClaims = new List<Claim>
            {
                new(ClaimTypes.NameIdentifier, user.Id),
                new(ClaimTypes.Name, user.UserName),
                new(ClaimTypes.Email, user.Email),
                new(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
            };
            authClaims.AddRange(userRoles.Select(userRole => new Claim(ClaimTypes.Role, userRole)));

            var token = GetToken(authClaims);
            var tokenString = new JwtSecurityTokenHandler().WriteToken(token);
            
            Response.Cookies.Append(config["JWT:CookieName"]!, tokenString, new CookieOptions {HttpOnly = false});
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