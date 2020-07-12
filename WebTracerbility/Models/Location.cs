using System;
using System.Collections.Generic;

namespace BidPhar_services.Models
{
    public partial class Location
    {
        public Location()
        {
            DataEntry = new HashSet<DataEntry>();
            ProductTransactions = new HashSet<ProductTransactions>();
        }

        public int IdLocation { get; set; }
        public string Location1 { get; set; }

        public virtual ICollection<DataEntry> DataEntry { get; set; }
        public virtual ICollection<ProductTransactions> ProductTransactions { get; set; }
    }
}
