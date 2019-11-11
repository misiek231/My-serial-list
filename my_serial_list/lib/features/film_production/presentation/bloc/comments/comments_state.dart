import 'package:equatable/equatable.dart';
import 'package:my_serial_list/features/film_production/domain/entities/comment.dart';
import 'package:meta/meta.dart';

abstract class CommentsState extends Equatable {
  const CommentsState();
  @override
  List<Object> get props => [];
}

class InitialCommentsState extends CommentsState {}

class Loaded extends CommentsState {
  final List<Comment> comments;

  Loaded({@required this.comments});

  @override
  List<Object> get props => [comments];
}

class Empty extends CommentsState {}

class Error extends CommentsState {
  final String error;

  Error({@required this.error});

  @override
  List<Object> get props => [error];
}
