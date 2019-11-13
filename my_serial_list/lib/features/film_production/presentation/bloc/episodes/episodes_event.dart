import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class EpisodeEvent extends Equatable {}

class GetData extends EpisodeEvent {
  final int filmProductionId;
  final int season;

  GetData({
    this.filmProductionId,
    this.season,
  });

  @override
  List<Object> get props => [filmProductionId, season];
}
