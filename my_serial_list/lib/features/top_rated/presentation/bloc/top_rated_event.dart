import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TopRatedEvent extends Equatable {
  TopRatedEvent([List props = const <dynamic>[]]) : super(props);
}

class GetMoreData extends TopRatedEvent {}
