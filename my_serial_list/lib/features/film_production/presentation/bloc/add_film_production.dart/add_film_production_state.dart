import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AddFilmProductionState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialAddFilmProductionState extends AddFilmProductionState {}

class Loading extends AddFilmProductionState {}

class Added extends AddFilmProductionState {}

class AddingError extends AddFilmProductionState {
  final String error;

  AddingError({@required this.error});

  @override
  List<Object> get props => [error];
}
