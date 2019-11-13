import 'package:meta/meta.dart';

class Episode {
  final String title;
  final String released;
  final int filmProductionId;
  final int season;
  final int episodeNumber;

  Episode({
    @required this.title,
    @required this.released,
    @required this.filmProductionId,
    @required this.season,
    @required this.episodeNumber,
  });
}
