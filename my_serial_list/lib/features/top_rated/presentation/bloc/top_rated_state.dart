import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:my_serial_list/features/top_rated/domain/entities/film_production_rating.dart';

@immutable
abstract class TopRatedState extends Equatable {
  TopRatedState([List props = const <dynamic>[]]) : super(props);
}

class Empty extends TopRatedState {}

class Loading extends TopRatedState {}

class Loaded extends TopRatedState {
  final List<FilmProductionRating> filmProductions;
  final int page;
  final bool hasReachedEndOfResults;

  Loaded(
      {@required this.filmProductions,
      @required this.page,
      @required this.hasReachedEndOfResults})
      : super([filmProductions, page, hasReachedEndOfResults]);
}

class Error extends TopRatedState {
  final String message;

  Error({@required this.message}) : super([message]);
}