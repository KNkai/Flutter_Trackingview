using BidPhar_services.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BidPhar_services.Services
{
    public interface IProductTransactions
    {
        IQueryable<ProductTransactions> GetProductTransactions { get; }
        List<ProductTransactions> GetProductTransactionsByIdProduct(string? id);
        Task<ProductTransactions> GetProductTransactionsById(int id);
        Task<int> AddProductTransactions(ProductTransactions productTransactions);
        //Task<int> UpdateProductTransactions(ProductTransactions productTransactions);
        Task<int> DelProductTransactions(int id);

    }
}
