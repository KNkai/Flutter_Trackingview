using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace BidPhar_services.Models.ViewModels
{
    public class ViewModelsDataEntry
    {
        public string IdProduct { get; set; }

        public string NameProduct { get; set; }

        public DateTime? ManufacturedDate { get; set; }

        public DateTime? ExpiredDate { get; set; }

        public string Manufactured { get; set; }

        public string Details { get; set; }

        public DateTime? DateChecked { get; set; }

        public int? IdLocation { get; set; }

    }
}
