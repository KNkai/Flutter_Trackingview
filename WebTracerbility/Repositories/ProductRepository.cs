using BidPhar_services.Models;
using BidPhar_services.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BidPhar_services.Repositories
{
    public class ProductRepository : IProduct
    {
        private readonly BID_PHARContext _db;
        public ProductRepository(BID_PHARContext db)
        {
            _db = db;
        }

        public IQueryable<Products> GetAllProducts => _db.Products;

        public async Task<int> AddListProduct(List<Products> listProducts)
        {
            if (_db != null)
            {
                foreach (var product in listProducts)
                {
                    await _db.AddAsync(product);
                }
                await _db.SaveChangesAsync();
                return 1;
            }
            return 0;
        }

        public async Task<int> AddProduct(Products products)
        {
            if (_db != null)
            {
                await _db.Products.AddAsync(products);
                await _db.SaveChangesAsync();
                return 1;
            }

            return 0;
        }

        public async Task<Products> GetProductById(string? id)
        {
            var products = _db.Products.Where(data => data.IdProduct == id).FirstOrDefault();
            return products;
        }

        public async Task<int> UpdateProduct(Products products)
        {
            if (_db != null)
            {
                var productTemp = _db.Products.Where(data => data.IdProduct == products.IdProduct).FirstOrDefault();
                productTemp.Manufactured = products.Manufactured;
                productTemp.ManufacturedDate = products.ManufacturedDate;
                productTemp.NameProduct = products.NameProduct;
                productTemp.ExpiredDate = products.ExpiredDate;
                productTemp.Details = products.Details;
                await _db.SaveChangesAsync();
                return 1;
            }

            return 0;
        }

        public async Task<int> DeleteProduct(string id)
        {
            var product = _db.Products.Where(data => data.IdProduct == id).FirstOrDefault();
            _db.Products.Remove(product);

            await _db.SaveChangesAsync();

            return 1;
        } 
    }
}
