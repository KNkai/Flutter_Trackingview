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
    public class ProductTransactionsController : ControllerBase
    {
        IProductTransactions _db;
        public ProductTransactionsController(IProductTransactions db)
        {
            _db = db;
        }

        [HttpGet]
        [Route("getall")]
        public IActionResult GetAllProductTransacntions()
        {
            IQueryable<ProductTransactions> model = _db.GetProductTransactions;
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
        [Route("gettrans")]
        public IActionResult GetProductTransactionsByIdProduct(string? id)
        {
            List<ProductTransactions> listModel = _db.GetProductTransactionsByIdProduct(id);
            if (listModel == null)
            {
                return NotFound();
            }
            else
            {
                return Ok(listModel);
            }
        }

        [HttpPost]
        [Route("add")]
        public async Task<IActionResult> AddProdTransAsync(ProductTransactions model)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var postId = await _db.AddProductTransactions(model);
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