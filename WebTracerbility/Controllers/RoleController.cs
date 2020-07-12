using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using BidPhar_services.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace BidPhar_services.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RoleController : ControllerBase
    {
        IRole _db;
        public RoleController(IRole db)
        {
            _db = db;
        }

        [HttpGet]
        [Route("getid")]
        public IActionResult GetRoleById(int? id)
        {
            var roles =_db.GetRolebyId(id);
            if (roles == null)
            {
                return NotFound();
            }
            else
            {
                return Ok(roles);
            }
        }
    }
}