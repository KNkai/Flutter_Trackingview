using BidPhar_services.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BidPhar_services.Services
{
    public interface IDataEntry
    {
        IQueryable<DataEntry> GetDataEntries { get; }

        Task<DataEntry> GetDataEntryById(string id);

        Task<int?> AddDataEntry(DataEntry dataEntry);
        void UpdateDataEntry(string id, DateTime startDate, DateTime endDate, int idLocation);

        Task<string> DelDataEntry(string id);
    }
}
