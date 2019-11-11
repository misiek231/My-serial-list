import 'package:equatable/equatable.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class GetMoreComments extends CommentEvent {
  final int id;

  GetMoreComments(this.id);

  @override
  List<Object> get props => [id];
}
