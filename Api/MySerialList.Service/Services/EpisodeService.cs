using MySerialList.Model.Episode;
using MySerialList.Repository.Interfaces;
using MySerialList.Service.Exception;
using MySerialList.Service.Interfaces;
using System;
using System.Collections.Generic;
using System.Net;
using System.Text;
using System.Threading.Tasks;

namespace MySerialList.Service.Services
{
    public class EpisodeService : IEpisodeService
    {
        private readonly IEpisodeRepository _episodeRepository;
        private readonly IFilmProductionRepository _filmProductionRepository;

        public EpisodeService(IEpisodeRepository episodeRepository, IFilmProductionRepository filmProductionRepository)
        {
            _episodeRepository = episodeRepository;
            _filmProductionRepository = filmProductionRepository;
        }

        public async Task AddEpisodeAsync(AddEpisode addEpisode)
        {
            if(!await _filmProductionRepository.ExsistsAsync(addEpisode.FilmProductionId))
            {
                throw new HttpStatusCodeException(HttpStatusCode.NotFound, "Nie znaleziono podanej produkcji filmowej.");
            }

            if (!await _filmProductionRepository.IsSeriesAsync(addEpisode.FilmProductionId))
            {
                throw new HttpStatusCodeException(HttpStatusCode.BadRequest, "Podana produkcja filmowa nie jest serialem.");
            }

            await _episodeRepository.AddEpisodeAsync(addEpisode);
        }

        public async Task<IEnumerable<EpisodeData>> GetAllEpisodesAsync(int filmProductionId)
        {
            if (!await _filmProductionRepository.ExsistsAsync(filmProductionId))
            {
                throw new HttpStatusCodeException(HttpStatusCode.NotFound, "Nie znaleziono podanej produkcji filmowej");
            }

            if (!await _filmProductionRepository.IsSeriesAsync(filmProductionId))
            {
                throw new HttpStatusCodeException(HttpStatusCode.BadRequest, "Podana produkcja filmowa nie jest serialem.");
            }

            return await _episodeRepository.GetAllEpisodes(filmProductionId);
        }

        public async Task<EpisodeData> GetEpisodeAsync(int id)
        {
            if (!await _episodeRepository.ExsistsAsync(id))
            {
                throw new HttpStatusCodeException(HttpStatusCode.NotFound, "Nie znaleziono odcinka");
            }

            return await _episodeRepository.GetEpisodeAsync(id);
        }
    }
}
