import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:my_serial_list/core/error/failures.dart';
import 'package:my_serial_list/features/film_production/domain/usecases/get_film_production.dart';
import './bloc.dart';
import 'package:meta/meta.dart';

class FilmProductionBloc
    extends Bloc<FilmProductionEvent, FilmProductionState> {
  final GetFilmProduction getFilmProduction;

  FilmProductionBloc({@required this.getFilmProduction});

  @override
  FilmProductionState get initialState => InitialFilmProductionState();

  @override
  Stream<FilmProductionState> mapEventToState(
    FilmProductionEvent event,
  ) async* {
    if (event is GetData) {
      yield Loading();
      final i = await getFilmProduction(Params(id: event.id));
      yield* i.fold((failure) async* {
        if (failure is RemoteFailure) {
          yield Error(error: failure.message);
        }
      }, (succes) async* {
        yield Loaded(filmProduction: succes);
      });
    }
  }
}
