using MySerialList.Repository.Interfaces;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace MySerialList.Repository.Repositories
{
    public class UserEpisdeRepository : IUserEpisdeRepository
    {
        public async Task<bool> IsEisodeAddedAsync(int episodeId, string userId)
        {
            return true;
        }
    }
}
