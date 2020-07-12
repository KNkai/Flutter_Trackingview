using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using BidPhar_services.Models;
using BidPhar_services.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace BidPhar_services.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductController : ControllerBase
    {
        IProduct _db;
        public ProductController(IProduct db)
        {
            _db = db;
        }

        [HttpGet]
        public IActionResult GetProductById(string? id)
        {
            var product = _db.GetProductById(id);
            if (product == null)
            {
                return NotFound();
            }
            else
            {
                return Ok(product);
            }
        }

        [HttpPost]
        [Route("add")]
        public async Task<IActionResult> AddProductAsync([FromBody]Products model)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var postId = await _db.AddProduct(model);
                    if (postId > 0)
                    {
                        return Ok(postId);
                    }
                    else
                    {
                        return NotFound();
                    }
                }
                catch (Exception e)
                {

                    return BadRequest();
                }

            }
            else
            {
                return BadRequest();
            }
        }

        [HttpPost]
        [Route("addlist")]
        public async Task<IActionResult> AddListProductAsync([FromBody]List<Products> model)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var postId = await _db.AddListProduct(model);
                    if (postId > 0)
                    {
                        return Ok(postId);
                    }
                    else
                    {
                        return NotFound();
                    }
                }
                catch (Exception e)
                {

                    return BadRequest();
                }

            }
            else
            {
                return BadRequest();
            }
        }

        [HttpPut]
        [Route("update")]
        public async Task<IActionResult> UpdateProductAsync([FromBody]Products model)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var postId = await _db.UpdateProduct(model);
                    if (postId > 0)
                    {
                        return Ok(postId);
                    }
                    else
                    {
                        return NotFound();
                    }
                }
                catch (Exception e)
                {

                    return BadRequest();
                }

            }
            else
            {
                return BadRequest();
            }
        }
    }
}