using BidPhar_services.Models;
using BidPhar_services.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BidPhar_services.Repositories
{
    public class RoleRepository : IRole
    {
        BID_PHARContext _db;
        public RoleRepository(BID_PHARContext db)
        {
            _db = db;
        }
        public Roles GetRolebyId(int? id)
        {
            Roles roles = _db.Roles.Where(data => data.IdRole == id).FirstOrDefault();
            return roles;
        }
    }
}
