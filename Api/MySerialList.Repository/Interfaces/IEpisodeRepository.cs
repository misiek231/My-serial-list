using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using MySerialList.Model.Episode;

namespace MySerialList.Repository.Interfaces
{
    public interface IEpisodeRepository
    {
        Task<bool> ExsistsAsync(int episodeId);
        Task AddEpisodeAsync(AddEpisode addEpisode);
        Task<IEnumerable<EpisodeData>> GetAllEpisodes(int filmProductionId);
        Task<EpisodeData> GetEpisodeAsync(int id);
    }
}
