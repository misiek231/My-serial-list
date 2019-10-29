import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:my_serial_list/features/top_rated/data/repositories/film_productions_repository_impl.dart';
import 'package:my_serial_list/features/top_rated/domain/usecases/top_rated.dart';
import 'package:my_serial_list/features/top_rated/presentation/bloc/bloc.dart';

import 'features/top_rated/data/datasources/film_productions_remote_data_source.dart';
import 'features/top_rated/domain/repositories/film_productions_repository.dart';

final sl = GetIt.instance;

init() {
  // ! Features - Number Trivia
  // Bloc
  sl.registerFactory(
    () => TopRatedBloc(
      getTopRated: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => TopRated(sl()));

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
