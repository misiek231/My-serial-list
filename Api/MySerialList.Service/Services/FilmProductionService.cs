using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Options;
using MySerialList.Component;
using MySerialList.Model.FilmProduction;
using MySerialList.Repository.Interfaces;
using MySerialList.Service.Interfaces;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace MySerialList.Service.Services
{
    public class FilmProductionService : IFilmProductionService
    {
        private readonly string _postersPath;
        private readonly IReviewFilmProductionRepository _reviewRepository;
        private readonly IHostingEnvironment _hostingEnvironment;
        private readonly IFilmProductionRepository _filmProductionRepository;

        public FilmProductionService(IOptions<AppSettings> appSettings, IReviewFilmProductionRepository reviewRepository, IHostingEnvironment hostingEnvironment, IFilmProductionRepository filmProductionRepository)
        {
            _postersPath = appSettings.Value.PostersPath;
            _reviewRepository = reviewRepository;
            _hostingEnvironment = hostingEnvironment;
            _filmProductionRepository = filmProductionRepository;
        }

        public Task<IEnumerable<FilmProductionRating>> GetAll(int page, FilmProductionType type, string search)
        {
            int filmProductionsPerPage = 100;
            return _filmProductionRepository.GetAll(page * filmProductionsPerPage - 100, filmProductionsPerPage, type, search);
        }

        public async Task AddFilmProductionAsync(AddFilmProduction addFilmProduction)
        {
            IFormFile file = addFilmProduction.Poster;
            string fileName = null;

            if (file != null)
            {
                if (file.Length > 0)
                {
                    fileName = Guid.NewGuid().ToString() + "." + file.FileName.Split('.').Last();
                    string filePath = Path.Combine(_postersPath, fileName);
                    using (FileStream fileStream = new FileStream(filePath, FileMode.Create))
                    {
                        await file.CopyToAsync(fileStream);
                    }
                }
            }
            await _filmProductionRepository.AddFilmProductionAsync(addFilmProduction, fileName);
        }

        public Task<FilmProductionData> GetFilmProduction(int id, string userId)
        {
            return _filmProductionRepository.GetFilmProduction(id, userId);
        }

        public async Task<IEnumerable<FilmProductionSearch>> SearchFilmProductions(string title, int page)
        {
            int filmProductionsPerPage = 100;
            return await _filmProductionRepository.SearchFilmProductions(title, page * filmProductionsPerPage - 100, filmProductionsPerPage);
        }
    }
}
