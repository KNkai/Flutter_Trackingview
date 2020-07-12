using BidPhar_services.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BidPhar_services.Services
{
    public interface IProduct
    {
        IQueryable<Products> GetAllProducts { get; }
        Task<Products> GetProductById(string? id);
        Task<int> AddProduct(Products products);
        Task<int> UpdateProduct(Products products);
        Task<int> AddListProduct(List<Products> listProducts);
        Task<int> DeleteProduct(string id);
    }
}
