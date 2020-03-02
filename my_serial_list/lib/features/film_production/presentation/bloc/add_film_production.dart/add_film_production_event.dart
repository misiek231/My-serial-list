import 'package:equatable/equatable.dart';
import 'package:my_serial_list/core/constants.dart';

abstract class AddFilmProductionEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddProduction extends AddFilmProductionEvent {
  final int filmProductionId;
  final WatchingStatus watchingStatus;
  final int episodes;

  AddProduction(this.filmProductionId, this.watchingStatus,
      {this.episodes = 0});

  @override
  List<Object> get props => [filmProductionId, episodes];
}
