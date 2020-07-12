using BidPhar_services.Models;
using BidPhar_services.Services;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BidPhar_services.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DataEntryController : ControllerBase
    {
        IDataEntry _db;
        public DataEntryController(IDataEntry db)
        {
            _db = db;
        }

        [HttpGet]
        [Route("getall")]
        public IActionResult GetAllDataEntry()
        {
            IQueryable<DataEntry> model = _db.GetDataEntries;
            if(model == null)
            {
                return NotFound();
            }
            else
            {
                return Ok(model);
            }
        }

        [HttpPost]
        [Route("Add")]
        public async Task<IActionResult> AddPost([FromBody]DataEntry model)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var postId = await _db.AddDataEntry(model);
                    if (postId > 0)
                    {
                        return Ok(postId);
                    }
                    else
                    {
                        return NotFound();
                    }
                }
                catch (Exception)
                {

                    return BadRequest();
                }

            }

            return BadRequest();
        }

        [HttpDelete]
        [Route("Del")]
        public async Task<IActionResult> DeletePost(string? id)
        {
            int result = 0;
            try
            {
                await _db.DelDataEntry(id.ToString());
                if (result == 0)
                {
                    return NotFound();
                }
                return Ok();
            }
            catch (Exception)
            {

                return BadRequest();
            }
        }
    }
}
