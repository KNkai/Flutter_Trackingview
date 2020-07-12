using System;
using System.Collections.Generic;

namespace BidPhar_services.Models
{
    public partial class Roles
    {
        public Roles()
        {
            Users = new HashSet<Users>();
        }

        public int IdRole { get; set; }
        public string NameRole { get; set; }

        public virtual ICollection<Users> Users { get; set; }
    }
}
