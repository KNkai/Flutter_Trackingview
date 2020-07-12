using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using BidPhar_services.Models;
using BidPhar_services.Services;
using Microsoft.AspNetCore.Mvc;

namespace BidPhar_services.Controllers
{
    public class TrackingController : Controller
    {
        IProductTransactions _productTranDb;
        IProduct _productDb;

        public TrackingController(IProductTransactions productTranDb, IProduct productDb)
        {
            _productDb = productDb;
            _productTranDb = productTranDb;
        }

        public IActionResult Index()
        {
            return View();
        }
        [HttpPost]
        public IActionResult GetListTranByIdProduct(string id)
        {
            var listProductTran = _productTranDb.GetProductTransactionsByIdProduct(id).ToList();
            
            if (listProductTran.Count == 0)
            {
                listProductTran = new List<ProductTransactions>();
                return Json(listProductTran, new Newtonsoft.Json.JsonSerializerSettings());
            }
            else
            {
                return Json(listProductTran, new Newtonsoft.Json.JsonSerializerSettings());
            }
            
        }

        [HttpPost]
        public IActionResult GetProductById(string id)
        {
            var product = _productDb.GetProductById(id);
            if (product == null)
            {
                return Json("console.log('sai rooi')");
            }
            else
            {
                return Json(product, new Newtonsoft.Json.JsonSerializerSettings());
            }
        }

        [HttpGet]
        public IActionResult GetProductTransById(int id)
        {
            var productTrans = _productTranDb.GetProductTransactionsById(id);
            return View(productTrans.Result);
        }
    }
}