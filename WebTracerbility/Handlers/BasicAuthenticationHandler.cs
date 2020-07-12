using BidPhar_services.Repositories;
using BidPhar_services.Services;
using Microsoft.AspNetCore.Authentication;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http.Headers;
using System.Security.Claims;
using System.Text;
using System.Text.Encodings.Web;
using System.Threading.Tasks;

namespace BidPhar_services.Handlers
{
    public class BasicAuthenticationHandler : AuthenticationHandler<AuthenticationSchemeOptions>
    {
        BID_PHARContext _db;
        public BasicAuthenticationHandler(
            IOptionsMonitor<AuthenticationSchemeOptions> options, 
            ILoggerFactory logger, 
            UrlEncoder encoder, 
            ISystemClock clock,
            BID_PHARContext db) : base(options, logger, encoder, clock)
        {
            _db = db;
        }

        protected override async Task<AuthenticateResult> HandleAuthenticateAsync()
        {
            if (!Request.Headers.ContainsKey("Authorization"))
            {
                return AuthenticateResult.Fail("Need to implement was not found");
            }
            try
            {
                var authenticationHeaderValue = AuthenticationHeaderValue.Parse(Request.Headers["Authorization"]);

                var bytes = Convert.FromBase64String(authenticationHeaderValue.Parameter);

                string[] credential = Encoding.UTF8.GetString(bytes).Split(":");
                string user = credential[0];
                string pass = credential[1];

                //var userTemp = _db.Login(user, pass);
                var userTemp = _db.Users.Where(data => data.Username == user && data.Password == pass).FirstOrDefault();

                if (userTemp == null)
                {
                    AuthenticateResult.Fail("Need to implement");
                }
                else
                {
                    var claims = new[] { new Claim(ClaimTypes.Name, userTemp.Username) };
                    var identity = new ClaimsIdentity(claims, Scheme.Name);
                    var principal = new ClaimsPrincipal(identity);
                    var ticket = new AuthenticationTicket(principal, Scheme.Name);

                    return AuthenticateResult.Success(ticket);
                }
            }
            catch(Exception e)
            {
                return AuthenticateResult.Fail("Error");
            }
            return AuthenticateResult.Fail("");
        }
    }
}
