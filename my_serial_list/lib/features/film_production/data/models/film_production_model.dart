import 'package:my_serial_list/features/film_production/domain/entities/film_production.dart';
import 'package:meta/meta.dart';

class FilmProductionModel extends FilmProduction {
  FilmProductionModel(
      {@required title,
      @required genre,
      @required released,
      @required filmProductionId,
      @required poster,
      @required plot,
      @required votes,
      @required rating,
      @required isSeries,
      @required language,
      @required actors,
      @required director,
      @required episodes})
      : super(
          title: title,
          language: language,
          actors: actors,
          director: director,
          genre: genre,
          released: released,
          filmProductionId: filmProductionId,
          poster: poster,
          plot: plot,
          votes: votes,
          rating: rating,
          episodes: episodes,
          isSeries: isSeries,
        );

  factory FilmProductionModel.fromJson(Map<String, dynamic> json) {
    return FilmProductionModel(
      title: json['title'],
      language: json['language'],
      actors: json['actors'],
      director: json['director'],
      genre: json['genre'],
      released: json['released'],
      filmProductionId: json['filmProductionId'],
      poster: json['poster'],
      plot: json['plot'],
      votes: json['votes'],
      rating: json['rating'],
      episodes: json['episodes'],
      isSeries: json['isSeries'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'language': language,
      'actors': actors,
      'director': director,
      'genre': genre,
      'released': released,
      'filmProductionId': filmProductionId,
      'poster': poster,
      'plot': plot,
      'votes': votes,
      'rating': rating,
      'episodes': episodes,
      'isSeries': isSeries
    };
  }
}
