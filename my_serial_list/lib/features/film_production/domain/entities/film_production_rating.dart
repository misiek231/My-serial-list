import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class FilmProductionRating extends Equatable {
  final String title;
  final String genre;
  final String released;
  final int filmProductionId;
  final String poster;
  final String plot;
  final int votes;
  final double rating;
  final bool isSeries;
  final int seasons;
  final bool last;
  final bool currentUserItem;
  final int totalEpisodes;

  FilmProductionRating({
    @required this.title,
    @required this.genre,
    @required this.released,
    @required this.filmProductionId,
    @required this.poster,
    @required this.plot,
    @required this.votes,
    @required this.rating,
    @required this.isSeries,
    @required this.seasons,
    @required this.last,
    @required this.currentUserItem,
    @required this.totalEpisodes,
  });

  @override
  List<Object> get props => [
        title,
        genre,
        released,
        filmProductionId,
        poster,
        plot,
        votes,
        rating,
        isSeries,
        seasons,
        last,
        currentUserItem,
        totalEpisodes,
      ];
}
