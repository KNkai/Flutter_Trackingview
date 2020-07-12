using System;
using System.Collections.Generic;

namespace BidPhar_services.Models
{
    public partial class Products
    {
        public Products()
        {
            ProductTransactions = new HashSet<ProductTransactions>();
        }

        public string IdProduct { get; set; }
        public string NameProduct { get; set; }
        public DateTime? ManufacturedDate { get; set; }
        public DateTime? ExpiredDate { get; set; }
        public string Manufactured { get; set; }
        public string Details { get; set; }

        public virtual ICollection<ProductTransactions> ProductTransactions { get; set; }
    }
}
