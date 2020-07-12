using BidPhar_services.Models;
using BidPhar_services.Services;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BidPhar_services.Repositories
{
    public class ProductTransactionsRepository : IProductTransactions
    {
        private readonly BID_PHARContext _db;

        public ProductTransactionsRepository(BID_PHARContext db)
        {
            _db = db;
        }

        public IQueryable<ProductTransactions> GetProductTransactions => _db.ProductTransactions;

        public async Task<int> AddProductTransactions(ProductTransactions productTransactions)
        {
            if (_db != null)
            {
                await _db.ProductTransactions.AddAsync(productTransactions);
                await _db.SaveChangesAsync();
                return productTransactions.IdProductTransactions;
            }
            return 0;
        }

        public async Task<int> DelProductTransactions(int id)
        {
            int result = 0;
            if (_db != null)
            {
                var data = await _db.ProductTransactions.FirstOrDefaultAsync(x => x.IdProductTransactions == id);

                if (data != null)
                {
                    _db.ProductTransactions.Remove(data);
                    await _db.SaveChangesAsync();
                    result = 1;
                }
                return result;
            }
            return result;
        }

        public async Task<ProductTransactions> GetProductTransactionsById(int id)
        {
            ProductTransactions productTransactions = _db.ProductTransactions.Where(data => data.IdProductTransactions == id).FirstOrDefault();
            return productTransactions;
        }

        public List<ProductTransactions> GetProductTransactionsByIdProduct(string? id)
        {
            List<ProductTransactions> listProTrans = new List<ProductTransactions>();
            listProTrans = _db.ProductTransactions.Where(data => data.IdProduct == id).ToList();
            return listProTrans;
        }
    }
}
