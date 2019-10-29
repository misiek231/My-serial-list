import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_serial_list/core/error/failures.dart';
import 'package:my_serial_list/features/top_rated/domain/entities/film_production_rating.dart';
import 'package:my_serial_list/features/top_rated/domain/usecases/top_rated.dart';

import 'top_rated_event.dart';
import 'top_rated_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class TopRatedBloc extends Bloc<TopRatedEvent, TopRatedState> {
  final TopRated getTopRated;

  TopRatedBloc({
    @required this.getTopRated,
  }) : assert(getTopRated != null);

  @override
  TopRatedState get initialState => Empty();

  @override
  Stream<TopRatedState> mapEventToState(
    TopRatedEvent event,
  ) async* {
    if (event is GetMoreData) {
      int page = 1;
      List<FilmProductionRating> list = List();
      if (currentState is Loaded) {
        page = (currentState as Loaded).page;
        list = (currentState as Loaded).filmProductions;
      }

      //yield Loading();
      final i = await getTopRated(Params(page: page));
      yield* i.fold((failure) async* {
        if (failure is RemoteFailure) {
          yield Error(message: failure.message);
        }
      }, (succes) async* {
        list.addAll(succes);
        yield Loaded(
          filmProductions: list,
          page: page + 1,
          hasReachedEndOfResults: succes.isEmpty,
        );
      });
    }
  }
}
