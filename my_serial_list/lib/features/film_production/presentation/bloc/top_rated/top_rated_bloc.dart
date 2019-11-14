import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_serial_list/core/error/failures.dart';
import 'package:my_serial_list/features/film_production/domain/entities/film_production_rating.dart';
import 'package:my_serial_list/features/film_production/domain/usecases/top_rated.dart';

import 'top_rated_event.dart';
import 'top_rated_state.dart';

class TopRatedBloc extends Bloc<TopRatedEvent, TopRatedState> {
  final TopRated getTopRated;

  TopRatedBloc({
    @required this.getTopRated,
  }) : assert(getTopRated != null);

  @override
  TopRatedState get initialState => Loading();

  @override
  Stream<TopRatedState> mapEventToState(
    TopRatedEvent event,
  ) async* {
    if (event is GetMoreData) {
      int page = 1;
      List<FilmProductionRating> list = List();
      if (state is Loaded && !event.resetPages) {
        page = (state as Loaded).page;
        list = (state as Loaded).filmProductions;
      }

      if (list.isEmpty) yield Loading();

      final i = await getTopRated(
        Params(
          page: page,
          type: event.filmProductionType,
          query: event.query,
        ),
      );

      yield* i.fold((failure) async* {
        if (failure is RemoteFailure) {
          yield Error(message: failure.message);
        }
      }, (succes) async* {
        list.addAll(succes);
        if (list.isEmpty)
          yield Empty();
        else
          yield Loaded(
            filmProductions: list,
            page: page + 1,
            hasReachedEndOfResults:
                succes.length != 0 ? succes.last.last : true,
          );
      });
    }
  }
}
