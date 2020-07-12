using System;
using System.Collections.Generic;

namespace BidPhar_services.Models
{
    public partial class DataEntry
    {
        public string IdDataEntry { get; set; }
        public DateTime? StartDate { get; set; }
        public DateTime? EndDate { get; set; }
        public int? IdLocation { get; set; }

        public virtual Location IdLocationNavigation { get; set; }
    }
}
