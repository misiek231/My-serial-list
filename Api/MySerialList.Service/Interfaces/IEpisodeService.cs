using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using MySerialList.Model.Episode;

namespace MySerialList.Service.Interfaces
{
    public interface IEpisodeService
    {
        Task AddEpisodeAsync(AddEpisode addEpisode);
        Task<EpisodeData> GetEpisodeAsync(int id);
        Task<IEnumerable<EpisodeData>> GetAllEpisodesAsync(int filmProductionId, int season, string userId);
    }
}
