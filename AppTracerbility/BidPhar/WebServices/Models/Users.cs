using System;
using System.Collections.Generic;

namespace BidPhar_services.Models
{
    public partial class Users
    {
        public string IdUser { get; set; }
        public string NameUser { get; set; }
        public int? IdRole { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        public string Email { get; set; }
        public string Avatar { get; set; }

        public virtual Roles IdRoleNavigation { get; set; }
    }
}
