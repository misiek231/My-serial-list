using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace MySerialList.Repository.Interfaces
{
    public interface IUserEpisdeRepository
    {
        Task<bool> IsEisodeAddedAsync(int episodeId, string userId);
    }
}
