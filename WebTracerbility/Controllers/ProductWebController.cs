using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using BidPhar_services.Handlers;
using BidPhar_services.Models;
using BidPhar_services.Models.ViewModels;
using BidPhar_services.Services;
using Microsoft.AspNetCore.Mvc;

namespace BidPhar_services.Controllers
{
    public class ProductWebController : Controller
    {
        IProduct _productDb;
        IProductTransactions _productTransactionsDb;
        ILocation _locationDb;

        bool checkProductExist = false;

        public ProductWebController(IProduct productDb, IProductTransactions productTransactionsDb, ILocation locationDb)
        {
            _locationDb = locationDb;
            _productDb = productDb;
            _productTransactionsDb = productTransactionsDb;
        }

        [HttpGet]
        public IActionResult Index()
        {
            IQueryable<Products> listProducts = _productDb.GetAllProducts;
            ViewBag.Message = listProducts;
            
            return View(listProducts);
        }

        [HttpGet]
        [NoDirectAccess]
        public async Task<IActionResult> CreateProduct(string id)
        {
            IQueryable<Location> listLocations = _locationDb.GetLocations;
            ViewBag.Message = listLocations;
            if (id == null)
            {
                return View(new ViewModelsDataEntry());
            }
            else
            {
                var modelDataEntry = new ViewModelsDataEntry();
                var product = await _productDb.GetProductById(id);
                var productTransactions = _productTransactionsDb.GetProductTransactionsByIdProduct(id).ElementAt(_productTransactionsDb.GetProductTransactionsByIdProduct(id).Count-1);
                modelDataEntry.IdProduct = product.IdProduct;
                modelDataEntry.ManufacturedDate = product.ManufacturedDate;
                modelDataEntry.ExpiredDate = product.ExpiredDate;
                modelDataEntry.Manufactured = product.Manufactured;
                modelDataEntry.NameProduct = product.NameProduct;
                modelDataEntry.DateChecked = DateTime.Today;
                modelDataEntry.IdLocation = productTransactions.IdLocation;
                modelDataEntry.Details = product.Details;

                if (modelDataEntry == null)
                {
                    return NotFound();
                }
                return View(modelDataEntry);
            }
        }
        
        [HttpPost]
        public async Task<IActionResult> CreateProduct(ViewModelsDataEntry model)
        {
            if (ModelState.IsValid)
            {
                ProductTransactions productTransactions = new ProductTransactions();
                productTransactions.IdProduct = model.IdProduct;
                productTransactions.DateChecked = DateTime.Now.Date;
                productTransactions.IdLocation = model.IdLocation;

                Products products = new Products();
                products.IdProduct = model.IdProduct;
                products.NameProduct = model.NameProduct;
                products.ManufacturedDate = model.ManufacturedDate;
                products.ExpiredDate = model.ExpiredDate;
                products.Manufactured = model.Manufactured;
                products.Details = model.Details;

                if (CheckExistProduct(model.IdProduct))
                {
                    await _productDb.AddProduct(products);
                    await _productTransactionsDb.AddProductTransactions(productTransactions);
                }
                else
                {
                    await _productDb.UpdateProduct(products);
                }

                return Json(new { isValid = true, html = Helper.RenderRazorViewToString(this, "_ViewAll", _productDb.GetAllProducts) });
            }
            return Json(new { isValid = false, html = Helper.RenderRazorViewToString(this, "CreateProduct", model) });
            //return RedirectToAction("index");
        }

        
        public async Task<IActionResult> DeleteProduct(string id)
        {
            await _productTransactionsDb.DeleteProductTransactionByIdProduct(id);
            await _productDb.DeleteProduct(id);
            return Json(new { isValid = true, html = Helper.RenderRazorViewToString(this, "_ViewAll", _productDb.GetAllProducts) });
        }

        bool CheckExistProduct(string id)
        {
            var product = _productDb.GetProductById(id).Result;
            return _productDb.GetProductById(id).Result != null ? false : true;
        }
    }
}