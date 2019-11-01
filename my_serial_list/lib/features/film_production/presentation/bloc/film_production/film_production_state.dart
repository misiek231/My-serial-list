import 'package:equatable/equatable.dart';
import 'package:my_serial_list/features/film_production/domain/entities/film_production.dart';
import 'package:meta/meta.dart';

abstract class FilmProductionState extends Equatable {
  const FilmProductionState();
  @override
  List<Object> get props => [];
}

class InitialFilmProductionState extends FilmProductionState {}


class Loaded extends FilmProductionState {
  final FilmProduction filmProduction;

  Loaded({@required this.filmProduction});

  @override
  List<Object> get props => [filmProduction];
}

class Error extends FilmProductionState {
  final String error;

  Error({@required this.error});

  @override
  List<Object> get props => [error];
}
