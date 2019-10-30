import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TopRatedEvent extends Equatable {
}

class GetMoreData extends TopRatedEvent {
  @override
  List<Object> get props => [];
}
