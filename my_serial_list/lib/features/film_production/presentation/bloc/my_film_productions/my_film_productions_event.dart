import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:my_serial_list/core/constants.dart';

@immutable
abstract class MyFilmProductionsEvent extends Equatable {}

class GetMoreData extends MyFilmProductionsEvent {
  final WatchingStatus watchingStatus;

  GetMoreData(this.watchingStatus);

  @override
  List<Object> get props => [watchingStatus];
}
