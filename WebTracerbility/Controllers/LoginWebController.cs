using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using BidPhar_services.Models;
using BidPhar_services.Services;
using Microsoft.AspNetCore.Mvc;

namespace BidPhar_services.Controllers
{
    public class LoginWebController : Controller
    {
        IUser _db;

        public LoginWebController(IUser db)
        {
            _db = db;
        }

        public IActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Login(Users users)
        {
            
            return Redirect("/");
        }
    }
}