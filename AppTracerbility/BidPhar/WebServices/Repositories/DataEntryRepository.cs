using BidPhar_services.Models;
using BidPhar_services.Services;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BidPhar_services.Repositories
{
    public class DataEntryRepository : IDataEntry
    {

        private readonly BID_PHARContext _db;
        public DataEntryRepository(BID_PHARContext db)
        {
            _db = db;
        }

        public IQueryable<DataEntry> GetDataEntries => _db.DataEntries;

        public async Task<DataEntry> GetDataEntryById(string id)
        {
            DataEntry dataEntry = _db.DataEntries.Where(data => data.IdDataEntry == id).FirstOrDefault();
            return dataEntry;
        }

        void IDataEntry.UpdateDataEntry(string id, DateTime startDate, DateTime endDate, int idLocation)
        {
            DataEntry dataTemp = _db.DataEntries.Where(data => data.IdDataEntry == id).FirstOrDefault();
            dataTemp.StartDate = startDate;
            dataTemp.EndDate = endDate;
            dataTemp.IdLocation = idLocation;

            _db.SaveChanges();
        }


        public async Task<int?> AddDataEntry(DataEntry dataEntry)
        {
            if(_db != null)
            {
                await _db.DataEntries.AddAsync(dataEntry);
                await _db.SaveChangesAsync();
                return dataEntry.IdLocation;
            }

            return 0;
        }

        public async Task<string> DelDataEntry(string id)
        {
            string result = "false";

            if (_db != null)
            {
                //Find the post for specific post id
                var data = await _db.DataEntries.FirstOrDefaultAsync(x => x.IdDataEntry == id);
                
                if (data != null)
                {
                    //Delete that post
                    _db.DataEntries.Remove(data);

                    //Commit the transaction
                    await _db.SaveChangesAsync();
                    result = "true";
                }
                return result;
            }

            return result;
        }
    }
}
