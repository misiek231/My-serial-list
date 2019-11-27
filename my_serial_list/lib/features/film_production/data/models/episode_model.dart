import 'package:meta/meta.dart';
import 'package:my_serial_list/features/film_production/domain/entities/episode.dart';

class EpisodeModel extends Episode {
  EpisodeModel({
    @required title,
    @required released,
    @required filmProductionId,
    @required season,
    @required episodeNumber,
    @required watched,
  }) : super(
          title: title,
          released: released,
          filmProductionId: filmProductionId,
          season: season,
          episodeNumber: episodeNumber,
          watched: watched,
        );

  factory EpisodeModel.fromJson(Map<String, dynamic> json) {
    return EpisodeModel(
      title: json['title'],
      released: json['released'],
      filmProductionId: json['filmProductionId'],
      season: json['season'],
      episodeNumber: json['episodeNumber'],
      watched: json['watched'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['released'] = this.released;
    data['filmProductionId'] = this.filmProductionId;
    data['season'] = this.season;
    data['episodeNumber'] = this.episodeNumber;
    data['watched'] = this.watched;
    return data;
  }
}
