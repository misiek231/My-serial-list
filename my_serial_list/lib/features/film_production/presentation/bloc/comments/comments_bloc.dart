import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:my_serial_list/core/error/failures.dart';
import 'package:my_serial_list/features/film_production/domain/usecases/get_comments.dart';
import './bloc.dart';
import 'package:meta/meta.dart';

class CommentsBloc extends Bloc<CommentEvent, CommentsState> {
  final GetComments getComments;

  CommentsBloc({@required this.getComments});

  @override
  CommentsState get initialState => InitialCommentsState();

  @override
  Stream<CommentsState> mapEventToState(
    CommentEvent event,
  ) async* {
    if (event is GetMoreComments) {
      yield InitialCommentsState();
      final i = await getComments(Params(id: event.id));
      yield* i.fold((failure) async* {
        if (failure is RemoteFailure) {
          yield Error(error: failure.message);
        }
      }, (succes) async* {
        if (succes.length != 0)
          yield Loaded(comments: succes);
        else
          yield Empty();
      });
    }
  }
}
