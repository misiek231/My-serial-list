import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:my_serial_list/features/film_production/domain/entities/episode.dart';

@immutable
abstract class EpisodeState extends Equatable {
  @override
  List<Object> get props => null;
}

class Loading extends EpisodeState {}

class Loaded extends EpisodeState {
  final List<Episode> episodes;

  Loaded({
    @required this.episodes,
  });

  @override
  List<Object> get props => [episodes];
}

class Error extends EpisodeState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}
