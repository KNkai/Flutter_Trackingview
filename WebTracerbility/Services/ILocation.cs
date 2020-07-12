using BidPhar_services.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BidPhar_services.Services
{
    public interface ILocation
    {
        IQueryable<Location> GetLocations { get; }
        Location LocationById(int? id);
    }
}
