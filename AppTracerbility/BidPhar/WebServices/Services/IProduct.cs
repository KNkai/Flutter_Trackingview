using BidPhar_services.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BidPhar_services.Services
{
    public interface IProduct
    {
        Task<Products> GetProductById(string? id);
        Task<int> AddProduct(Products products);
        Task<int> UpdateProduct(Products products);
    }
}
