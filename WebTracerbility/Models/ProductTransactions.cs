using System;
using System.Collections.Generic;

namespace BidPhar_services.Models
{
    public partial class ProductTransactions
    {
        public int IdProductTransactions { get; set; }
        public string IdProduct { get; set; }
        public int? IdLocation { get; set; }
        public string Detail { get; set; }
        public DateTime? DateChecked { get; set; }
        public string IdUser { get; set; }

        public virtual Location IdLocationNavigation { get; set; }
        public virtual Products IdProductNavigation { get; set; }
        public virtual Users IdUserNavigation { get; set; }
    }
}
