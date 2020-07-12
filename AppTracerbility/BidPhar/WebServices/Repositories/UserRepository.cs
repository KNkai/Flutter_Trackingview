using BidPhar_services.Models;
using BidPhar_services.Services;
using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BidPhar_services.Repositories
{
    public class UserRepository : IUser
    {
        BID_PHARContext _db;
        public UserRepository(BID_PHARContext db)
        {
            _db = db;
        }
        public IQueryable<Users> GetAllUsers => _db.Users;

        public Users Login(string userName)
        {
            var user = _db.Users.Where(data => data.Username == userName).FirstOrDefault();

            if (user!=null)
            {
                return user;
            }
            else
            {
                return null;
            }
        }
    }
}
