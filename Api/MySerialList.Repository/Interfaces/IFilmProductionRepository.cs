﻿using MySerialList.Model.FilmProduction;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace MySerialList.Repository.Interfaces
{
    public interface IFilmProductionRepository
    {
        Task AddFilmProductionAsync(AddFilmProduction addFilmProduction, string fileName);
        Task<IEnumerable<FilmProductionRating>> GetTopRated(int from, int to);
        Task<IEnumerable<FilmProductionSearch>> SearchFilmProductions(string title, int from, int to);
        Task<FilmProductionData> GetFilmProduction(int id);
        Task<bool> Exsists(int filmProductionId);
    }
}
