using BidPhar_services.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BidPhar_services.Services
{
    public interface IUser
    {
        IQueryable<Users> GetAllUsers { get; }

        Users Login(string userName);
    }
}
