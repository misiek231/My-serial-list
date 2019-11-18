
using HtmlAgilityPack;
using Microsoft.EntityFrameworkCore;
using MySerialList.Data;
using MySerialList.Data.Model;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Web;

namespace MySerialList.FilmwebParser
{
    internal class Program
    {
        private static void Main(string[] args)
        {
            new Program().ParseSerials().Wait();
        }

        private async Task ParseSerials()
        {
            for (int i = 282; i <= 1000; i++)
            {
                Console.WriteLine("page " + i);
                string url = $"https://www.filmweb.pl/serials/search?page={i}";
                HtmlWeb web = new HtmlWeb();
                HtmlDocument doc = await web.LoadFromWebAsync(url);
                HtmlNode documentNode = doc.DocumentNode;
                HtmlNodeCollection filmsNodes = documentNode.SelectNodes("//li[@class='hits__item']");


                foreach (HtmlNode film in filmsNodes)
                {

                    try
                    {

                        string link = "https://www.filmweb.pl" + film.SelectSingleNode(".//a[@class='filmPreview__link']").Attributes["href"].Value + "/episodes";
                        string Poster = film.SelectSingleNode(".//div[@class='filmPoster__link']")?.SelectSingleNode(".//img")?.Attributes["data-src"]?.Value;
                        string Title = film.SelectSingleNode(".//h3[@class='filmPreview__title']")?.InnerText?.Decode();
                        string Released = film.SelectSingleNode(".//span[@class='filmPreview__year']")?.InnerText?.Decode();
                        string Plot = film.SelectSingleNode(".//div[@class='filmPreview__description']")?.InnerText?.Decode();
                        string Genre = film.SelectSingleNode(".//div[@class='filmPreview__info filmPreview__info--genres']")?.SelectSingleNode(".//a")?.InnerText?.Decode();
                        string Language = film.SelectSingleNode(".//div[@class='filmPreview__info filmPreview__info--countries']")?.SelectSingleNode(".//a")?.InnerText?.Decode();
                        string Director = film.SelectSingleNode(".//div[@class='filmPreview__info filmPreview__info--directors']")?.SelectSingleNode(".//a")?.InnerText?.Decode();
                        string Actors = film.SelectSingleNode(".//div[@class='filmPreview__info filmPreview__info--cast']")?.SelectSingleNode(".//a")?.InnerText?.Decode();

                        FilmProduction filmProduction = new FilmProduction
                        {
                            Poster = Poster,
                            Title = Title,
                            Released = Released,
                            Plot = Plot,
                            Genre = Genre,
                            Language = Language,
                            Director = Director,
                            Actors = Actors,
                            IsSeries = true
                        };

                        Console.WriteLine(Title);

                        DbContextOptionsBuilder<MySerialListDBContext> optionsBuilder = new DbContextOptionsBuilder<MySerialListDBContext>();
                        optionsBuilder.UseSqlServer("Server = tcp:35.184.110.50, 1433; User ID = sa; Password = Wozniak; Database = MySerialList");
                        using (MySerialListDBContext context = new MySerialListDBContext(optionsBuilder.Options))
                        {

                            await context.FilmProductions.AddAsync(filmProduction);
                            await context.SaveChangesAsync();
                        }


                        await AddEpisodes(link, filmProduction.Id);
                    }
                    catch
                    {
                        continue;
                    }
                }
            }
        }

        private async Task AddEpisodes(string link, int filmProductionId)
        {
            HtmlWeb web = new HtmlWeb();
            HtmlDocument doc = await web.LoadFromWebAsync(link +"/1");
            HtmlNode documentNode = doc.DocumentNode;
            HtmlNodeCollection seasons = documentNode.SelectNodes("//div[@class='episodesContainer episodesContainer--season ']");

            List<Episode> episodesList = new List<Episode>();

            if (seasons == null)
            {
                doc = await web.LoadFromWebAsync($"{link}");
                documentNode = doc.DocumentNode;
                HtmlNodeCollection episodes = documentNode.SelectNodes("//li[@class='episode ']");
                Console.WriteLine("sezon 1");
                foreach (HtmlNode episodeNode in episodes)
                {
                    string title = episodeNode.SelectSingleNode(".//div[@class='episode__title']").InnerText.Decode();
                    string released = episodeNode.SelectSingleNode(".//div[@class='episode__dates']").InnerText.Decode();

                    Episode episode = new Episode
                    {
                        Title = title.Contains(" - ") ? title.Split(" - ")[1] : title,
                        EpisodeNumber = title.Contains(" - ") ? int.TryParse(title.Split(" - ")[0], out int k) ? k : 0 : 0,
                        Season = 1,
                        Released = released,
                        FilmProductionId = filmProductionId
                    };
                    episodesList.Add(episode);
                    Console.WriteLine("   " + episode.Title);
                }
            }
            else
            {
                for (int i = 1; i <= seasons.Count + 1; i++)
                {
                    doc = await web.LoadFromWebAsync($"{link}/{i}");
                    documentNode = doc.DocumentNode;
                    HtmlNodeCollection episodes = documentNode.SelectNodes("//li[@class='episode ']");
                    Console.WriteLine("sezon " + i, ConsoleColor.Green);
                    foreach (HtmlNode episodeNode in episodes)
                    {
                        string title = episodeNode.SelectSingleNode(".//div[@class='episode__title']").InnerText.Decode();
                        string released = episodeNode.SelectSingleNode(".//div[@class='episode__dates']").InnerText.Decode();

                        Episode episode = new Episode
                        {
                            Title = title.Contains(" - ") ? title.Split(" - ")[1] : title,
                            EpisodeNumber = title.Contains(" - ") ? int.TryParse(title.Split(" - ")[0], out int k) ? k : 0 : 0,
                            Season = i,
                            Released = released,
                            FilmProductionId = filmProductionId
                        };
                        episodesList.Add(episode);

                        Console.WriteLine("   " + episode.Title);
                    }
                }
            }

            DbContextOptionsBuilder<MySerialListDBContext> optionsBuilder = new DbContextOptionsBuilder<MySerialListDBContext>();
            optionsBuilder.UseSqlServer("Server = tcp:35.184.110.50, 1433; User ID = sa; Password = Wozniak; Database = MySerialList");
            using MySerialListDBContext context = new MySerialListDBContext(optionsBuilder.Options);
            await context.Episodes.AddRangeAsync(episodesList);
            await context.SaveChangesAsync();
        }

        private async Task ParseFilms()
        {


            for (int i = 1; i <= 1000; i++)
            {
                string url = $"https://www.filmweb.pl/films/search?page={i}";
                HtmlWeb web = new HtmlWeb();
                HtmlDocument doc = await web.LoadFromWebAsync(url);
                HtmlNode documentNode = doc.DocumentNode;
                HtmlNodeCollection filmsNodes = documentNode.SelectNodes("//li[@class='hits__item']");

                List<FilmProduction> films = new List<FilmProduction>();

                foreach (HtmlNode film in filmsNodes)
                {
                    string Poster = film.SelectSingleNode(".//div[@class='filmPoster__link']")?.SelectSingleNode(".//img")?.Attributes["data-src"]?.Value;
                    string Title = film.SelectSingleNode(".//h3[@class='filmPreview__title']")?.InnerText?.Decode();
                    string Released = film.SelectSingleNode(".//span[@class='filmPreview__year']")?.InnerText?.Decode();
                    string Plot = film.SelectSingleNode(".//div[@class='filmPreview__description']")?.InnerText?.Decode();
                    string Genre = film.SelectSingleNode(".//div[@class='filmPreview__info filmPreview__info--genres']")?.SelectSingleNode(".//a")?.InnerText?.Decode();
                    string Language = film.SelectSingleNode(".//div[@class='filmPreview__info filmPreview__info--countries']")?.SelectSingleNode(".//a")?.InnerText?.Decode();
                    string Director = film.SelectSingleNode(".//div[@class='filmPreview__info filmPreview__info--directors']")?.SelectSingleNode(".//a")?.InnerText?.Decode();
                    string Actors = film.SelectSingleNode(".//div[@class='filmPreview__info filmPreview__info--cast']")?.SelectSingleNode(".//a")?.InnerText?.Decode();

                    FilmProduction filmProduction = new FilmProduction
                    {
                        Poster = Poster,
                        Title = Title,
                        Released = Released,
                        Plot = Plot,
                        Genre = Genre,
                        Language = Language,
                        Director = Director,
                        Actors = Actors,
                        IsSeries = false
                    };

                    films.Add(filmProduction);
                }
                DbContextOptionsBuilder<MySerialListDBContext> optionsBuilder = new DbContextOptionsBuilder<MySerialListDBContext>();
                optionsBuilder.UseSqlServer("Server = tcp:35.184.110.50, 1433; User ID = sa; Password = Wozniak; Database = MySerialList");
                using (MySerialListDBContext context = new MySerialListDBContext(optionsBuilder.Options))
                {

                    await context.FilmProductions.AddRangeAsync(films);
                    await context.SaveChangesAsync();
                }
                Console.WriteLine("page " + i);
            }
        }
    }

    internal static class Extensions
    {
        public static string Decode(this string str)
        {
            return HttpUtility.HtmlDecode(str);
        }
    }
}
