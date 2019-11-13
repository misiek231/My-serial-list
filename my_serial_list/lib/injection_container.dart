import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:my_serial_list/features/film_production/data/repositories/film_productions_repository_impl.dart';
import 'package:my_serial_list/features/film_production/domain/usecases/get_comments.dart';
import 'package:my_serial_list/features/film_production/domain/usecases/get_episodes.dart';
import 'package:my_serial_list/features/film_production/domain/usecases/get_film_production.dart';
import 'package:my_serial_list/features/film_production/domain/usecases/top_rated.dart';
import 'package:my_serial_list/features/film_production/presentation/bloc/comments/bloc.dart';
import 'package:my_serial_list/features/film_production/presentation/bloc/episodes/episodes_bloc.dart';
import 'package:my_serial_list/features/film_production/presentation/bloc/film_production/bloc.dart';
import 'package:my_serial_list/features/film_production/presentation/bloc/top_rated/bloc.dart';

import 'features/film_production/data/datasources/film_productions_remote_data_source.dart';
import 'features/film_production/domain/repositories/film_productions_repository.dart';

final sl = GetIt.instance;

init() {
  // ! Features - Number Trivia
  // Bloc

  sl.registerFactory(
    () => EpisodeBloc(
      getEpisodes: sl(),
    ),
  );

  sl.registerFactory(
    () => CommentsBloc(
      getComments: sl(),
    ),
  );

  sl.registerFactory(
    () => TopRatedBloc(
      getTopRated: sl(),
    ),
  );

  sl.registerFactory(
    () => FilmProductionBloc(
      getFilmProduction: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetEpisodes(sl()));
  sl.registerLazySingleton(() => TopRated(sl()));
  sl.registerLazySingleton(() => GetFilmProduction(sl()));
  sl.registerLazySingleton(() => GetComments(sl()));

  // Repository
  sl.registerLazySingleton<FilmProductionsRepository>(
    () => FilmProductionsRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<FilmProductionsRemoteDataSource>(
    () => FilmProductionsRemoteDataSourceImpl(client: sl()),
  );

  //! External
  sl.registerLazySingleton(() => http.Client());
}
