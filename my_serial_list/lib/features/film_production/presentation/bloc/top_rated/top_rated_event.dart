import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:my_serial_list/core/constants.dart';

@immutable
abstract class TopRatedEvent extends Equatable {}

class GetMoreData extends TopRatedEvent {
  final FilmProductionType filmProductionType;
  final String query;
  final bool resetPages;

  GetMoreData(this.filmProductionType, this.query, {this.resetPages = false});

  @override
  List<Object> get props => [filmProductionType, query];
}
