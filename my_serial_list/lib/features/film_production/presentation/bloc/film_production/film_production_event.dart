import 'package:equatable/equatable.dart';

abstract class FilmProductionEvent extends Equatable {
  const FilmProductionEvent();

  @override
  List<Object> get props => [];
}

class GetData extends FilmProductionEvent {
  final int id;

  GetData(this.id);

  @override
  List<Object> get props => [id];
}
