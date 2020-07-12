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
    public class LocationController : ControllerBase
    {
        ILocation _db;
        public LocationController(ILocation db)
        {
            _db = db;
        }

        [HttpGet]
        [Route("getall")]
        public IActionResult GetAllLocation()
        {
            var model = _db.GetLocations;
            if (model == null)
            {
                return NotFound();
            }
            else
            {
                return Ok(model);
            }
        }

        [HttpGet]
        public IActionResult GetLocationById(int? id)
        {
            var location = _db.LocationById(id);
            if (location == null)
            {
                return NotFound();
            }
            else
            {
                return Ok(location);
            }
        }
    }
}