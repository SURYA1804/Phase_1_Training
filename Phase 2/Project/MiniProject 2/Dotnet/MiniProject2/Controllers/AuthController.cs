using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity.Data;
using Microsoft.AspNetCore.Mvc;
using MiniProject2.Model;
using System.Security.Claims;

namespace MiniProject2.Controllers
{
    [Route("Auth")]
    [ApiController]
    public class AuthController : ControllerBase
    {
        Microsoft.Extensions.Options.IOptions<Jwtoptions> jwtoptions;

        public AuthController(Microsoft.Extensions.Options.IOptions<Jwtoptions> jwtoptions)
        {
            this.jwtoptions = jwtoptions;
        }

        [HttpGet("Login")]
        public IActionResult Login(string Name, string Password)
        {
            using (var client = new HttpClient())
            {
                var url = $"http://127.0.0.1:5001/ValidateUser?Name={Name}&Password={Password}";

                var response = client.GetAsync(url).Result;

                if (response.IsSuccessStatusCode)
                {
                    var result = response.Content.ReadAsStringAsync().Result;

                    var userResponse = System.Text.Json.JsonSerializer.Deserialize<UserResponse>(result,
                        new System.Text.Json.JsonSerializerOptions { PropertyNameCaseInsensitive = true }
                    );
                var claims = new List<Claim>
                {
                    new Claim(ClaimTypes.Name,userResponse.User.Name),
                    new Claim(ClaimTypes.Role,userResponse.User.Role)

                };
                    var token = JwtService.CreateJWTToken(jwtoptions.Value, claims);
                    return Ok(new
                    {
                        User = userResponse.User,
                        Token = token
                    });
                }
                else if (response.StatusCode == System.Net.HttpStatusCode.NotFound)
                {
                    return NotFound("User not found");
                }
                else
                {
                    return StatusCode((int)response.StatusCode, "Something went wrong");
                }
            }

        }
    }
}
