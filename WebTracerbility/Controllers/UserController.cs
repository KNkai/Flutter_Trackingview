using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using BidPhar_services.Models;
using BidPhar_services.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace BidPhar_services.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly IUser _db;
        public UserController(IUser db)
        {
            _db = db;
        }

        [HttpGet]
        [Route("getall")]
        public IActionResult GetAllUser()
        {
            var user = _db.GetAllUsers;
            if (user == null)
            {
                return NotFound();
            }
            else
            {
                return Ok(user);
            }
        }

        [HttpGet]
        [Route("login")]
        public IActionResult Login()
        {
            string userName = HttpContext.User.Identity.Name;
            var users = _db.Login(userName);
            if (users == null)
            {
                return NotFound();
            }
            else 
            { 
                return Ok(users); 
            }
        }
    }
}