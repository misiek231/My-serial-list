import 'package:my_serial_list/features/top_rated/domain/entities/film_production_rating.dart';
import 'package:meta/meta.dart';

class FilmProductionRatingModel extends FilmProductionRating {
  FilmProductionRatingModel({
    @required title,
    @required genre,
    @required released,
    @required filmProductionId,
    @required poster,
    @required plot,
    @required votes,
    @required rating,
    @required isSeries,
  }) : super(
          title: title,
          genre: genre,
          released: released,
          filmProductionId: filmProductionId,
          poster: poster,
          plot: plot,
          votes: votes,
          rating: rating,
          isSeries: isSeries,
        );

  factory FilmProductionRatingModel.fromJson(Map<String, dynamic> json) {
    return FilmProductionRatingModel(
      title: json['title'],
      genre: json['genre'],
      released: json['released'],
      filmProductionId: json['filmProductionId'],
      poster: json['poster'],
      plot: json['plot'],
      votes: json['votes'],
      rating: json['rating'],
      isSeries: json['isSeries'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['genre'] = this.genre;
    data['released'] = this.released;
    data['filmProductionId'] = this.filmProductionId;
    data['poster'] = this.poster;
    data['plot'] = this.plot;
    data['votes'] = this.votes;
    data['rating'] = this.rating;
    data['isSeries'] = this.isSeries;
    return data;
  }
}
