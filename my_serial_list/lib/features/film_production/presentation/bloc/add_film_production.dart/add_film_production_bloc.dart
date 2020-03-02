import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:my_serial_list/core/error/failures.dart';
import './bloc.dart';
import 'package:meta/meta.dart';

class AddFilmProductionBloc
    extends Bloc<AddFilmProductionEvent, AddFilmProductionState> {
  //final AddFilmProduction getAddFilmProduction;

  // AddFilmProductionBloc({@required this.getAddFilmProduction});

  @override
  AddFilmProductionState get initialState => InitialAddFilmProductionState();

  @override
  Stream<AddFilmProductionState> mapEventToState(
    AddFilmProductionEvent event,
  ) async* {
    if (event is AddProduction) {
      yield Loading();
      await Future.delayed(Duration(seconds: 1));
      yield Added();

      // yield InitialAddFilmProductionState();
      // final i = await getAddFilmProduction(Params(id: event.id));
      // yield* i.fold((failure) async* {
      //   if (failure is RemoteFailure) {
      //     yield Error(error: failure.message);
      //   }
      // }, (succes) async* {
      //   if (succes.length != 0)
      //     yield Loaded(addfilmproduction: succes);
      //   else
      //     yield Empty();
      // });
    }
  }
}
