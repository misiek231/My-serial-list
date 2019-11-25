import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_serial_list/core/error/failures.dart';
import 'package:my_serial_list/features/film_production/domain/entities/film_production_rating.dart';
import 'package:my_serial_list/features/film_production/domain/usecases/get_my_film_production.dart';

import 'bloc.dart';

class MyFilmProductionsBloc
    extends Bloc<MyFilmProductionsEvent, MyFilmProductionsState> {
  final GetMyFilmProductions getMyFilmProductions;

  MyFilmProductionsBloc({
    @required this.getMyFilmProductions,
  }) : assert(getMyFilmProductions != null);

  @override
  MyFilmProductionsState get initialState => Loading();

  @override
  Stream<MyFilmProductionsState> mapEventToState(
    MyFilmProductionsEvent event,
  ) async* {
    if (event is GetMoreData) {
      int page = 1;
      List<FilmProductionRating> list = List();
      if (state is Loaded) {
        page = (state as Loaded).page;
        list = (state as Loaded).filmProductions;
      }

      if (list.isEmpty) yield Loading();

      final i = await getMyFilmProductions(
        Params(
          page: page,
          watchingStatus: event.watchingStatus,
        ),
      );

      yield* i.fold((failure) async* {
        if (failure is RemoteFailure) {
          yield Error(message: failure.message);
        }
        if (failure is NoAuthorizationFailure) {
          yield NotLoggedIn();
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
