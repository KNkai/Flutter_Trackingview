using BidPhar_services.Models;
using BidPhar_services.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BidPhar_services.Repositories
{
    public class LocationRepository : ILocation
    {
        private readonly BID_PHARContext _db;
        public LocationRepository(BID_PHARContext db)
        {
            _db = db;
        }

        public IQueryable<Location> GetLocations => _db.Locations;

        public Location LocationById(int? id)
        {
            var location = _db.Locations.Where(data => data.IdLocation == id).FirstOrDefault();
            return location;
        }
    }
}
