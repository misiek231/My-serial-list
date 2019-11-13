import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TopRatedEvent extends Equatable {}

class GetMoreData extends TopRatedEvent {
  final bool serials;

  GetMoreData(this.serials);

  @override
  List<Object> get props => [];
}
