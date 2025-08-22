using Microsoft.IdentityModel.Tokens;
using MiniProject2.Model;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace MiniProject2
{

    public class JwtService
    {
        public static string CreateJWTToken(Jwtoptions options, IEnumerable<Claim> claims)
        {
            var creds = new SigningCredentials(new SymmetricSecurityKey(Encoding.UTF8.GetBytes(options.key)), SecurityAlgorithms.HmacSha256);
            var token = new JwtSecurityToken(
                issuer: options.Issuer,
                audience: options.Audience,
                claims: claims,
                expires: DateTime.Now.AddMinutes(30),
                signingCredentials: creds);

            return new JwtSecurityTokenHandler().WriteToken(token);
        }

    }
}
