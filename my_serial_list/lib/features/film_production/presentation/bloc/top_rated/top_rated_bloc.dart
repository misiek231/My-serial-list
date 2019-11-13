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
  TopRatedState get initialState => Empty();

  @override
  Stream<TopRatedState> mapEventToState(
    TopRatedEvent event,
  ) async* {
    if (event is GetMoreData) {
      int page = 1;
      List<FilmProductionRating> list = List();
      if (state is Loaded) {
        page = (state as Loaded).page;
        list = (state as Loaded).filmProductions;
      }

      //yield Loading();
      final a = Params(page: page, type: event.serials ? 3 : 2);
      final i = await getTopRated(a);

      yield* i.fold((failure) async* {
        if (failure is RemoteFailure) {
          yield Error(message: failure.message);
        }
      }, (succes) async* {
        list.addAll(succes);
        yield Loaded(
          filmProductions: list,
          page: page + 1,
          hasReachedEndOfResults: succes.last.last,
        );
      });
    }
  }
}
