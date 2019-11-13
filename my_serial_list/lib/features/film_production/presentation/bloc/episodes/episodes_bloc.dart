import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_serial_list/core/error/failures.dart';
import 'package:my_serial_list/features/film_production/domain/usecases/get_episodes.dart';

import 'bloc.dart';

class EpisodeBloc extends Bloc<EpisodeEvent, EpisodeState> {
  final GetEpisodes getEpisodes;

  EpisodeBloc({
    @required this.getEpisodes,
  }) : assert(getEpisodes != null);

  @override
  EpisodeState get initialState => Loading();

  @override
  Stream<EpisodeState> mapEventToState(
    EpisodeEvent event,
  ) async* {
    if (event is GetData) {
      final i = await getEpisodes(Params(
        filmProductionId: event.filmProductionId,
        season: event.season,
      ));
      yield Loading();
      yield* i.fold((failure) async* {
        if (failure is RemoteFailure) {
          yield Error(message: failure.message);
        }
      }, (succes) async* {
        yield Loaded(
          episodes: succes,
        );
      });
    }
  }
}
