import 'package:meta/meta.dart';

class FilmProduction {
  final int filmProductionId;
  final String title;
  final String released;
  final String genre;
  final String director;
  final String actors;
  final String plot;
  final String language;
  final String poster;
  final int votes;
  final double rating;
  final bool isSeries;
  final int episodes;
  final int myRating;
  final bool isInMyList;

  FilmProduction({
    @required this.filmProductionId,
    @required this.title,
    @required this.released,
    @required this.genre,
    @required this.director,
    @required this.actors,
    @required this.plot,
    @required this.language,
    @required this.poster,
    @required this.votes,
    @required this.rating,
    @required this.isSeries,
    @required this.episodes,
    @required this.myRating,
    @required this.isInMyList,
  });
}
