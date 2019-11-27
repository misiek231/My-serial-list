import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:my_serial_list/core/presentation/bloc/main_page/main.dart';
import 'package:my_serial_list/features/account/data/datasources/authentication_local_datasource.dart';
import 'package:my_serial_list/features/account/domain/usecases/get_token.dart';
import 'package:my_serial_list/features/account/domain/usecases/get_username.dart';
import 'package:my_serial_list/features/account/domain/usecases/login.dart';
import 'package:my_serial_list/features/account/domain/usecases/logout.dart';
import 'package:my_serial_list/features/film_production/data/repositories/film_productions_repository_impl.dart';
import 'package:my_serial_list/features/film_production/domain/usecases/get_comments.dart';
import 'package:my_serial_list/features/film_production/domain/usecases/get_episodes.dart';
import 'package:my_serial_list/features/film_production/domain/usecases/get_film_production.dart';
import 'package:my_serial_list/features/film_production/domain/usecases/get_my_film_production.dart';
import 'package:my_serial_list/features/film_production/domain/usecases/top_rated.dart';
import 'package:my_serial_list/features/film_production/presentation/bloc/add_film_production.dart/bloc.dart';
import 'package:my_serial_list/features/film_production/presentation/bloc/comments/bloc.dart';
import 'package:my_serial_list/features/film_production/presentation/bloc/episodes/episodes_bloc.dart';
import 'package:my_serial_list/features/film_production/presentation/bloc/film_production/bloc.dart';
import 'package:my_serial_list/features/film_production/presentation/bloc/my_film_productions/bloc.dart';
import 'package:my_serial_list/features/film_production/presentation/bloc/top_rated/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/account/data/datasources/authentication_remote_datasource.dart';
import 'features/account/data/repositories/authetication_repository_impl.dart';
import 'features/account/domain/repositories/authetication_repository.dart';
import 'features/account/domain/usecases/register.dart';
import 'features/account/presentation/bloc/authentication/authentication_bloc.dart';
import 'features/film_production/data/datasources/film_productions_remote_data_source.dart';
import 'features/film_production/domain/repositories/film_productions_repository.dart';

final sl = GetIt.instance;

Future init() async {
  // Bloc

  sl.registerFactory(
    () => AddFilmProductionBloc(),
  );

  sl.registerFactory(
    () => MyFilmProductionsBloc(
      getMyFilmProductions: sl(),
    ),
  );

  sl.registerFactory(
    () => MainBloc(
      getToken: sl(),
      getUsername: sl(),
    ),
  );

  sl.registerFactory(
    () => AuthenticationBloc(
      login: sl(),
      register: sl(),
    ),
  );

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
  sl.registerLazySingleton(() => GetMyFilmProductions(sl()));
  sl.registerLazySingleton(() => Logout(sl()));
  sl.registerLazySingleton(() => GetUsername(sl()));
  sl.registerLazySingleton(() => Login(sl()));
  sl.registerLazySingleton(() => Register(sl()));
  sl.registerLazySingleton(() => GetToken(sl()));
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

  sl.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(
      authenticationLocalDataSource: sl(),
      authenticationRemoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<AuthenticationRemoteDataSource>(
    () => AuthenticationRemoteDataSourceImpl(httpClient: sl()),
  );

  sl.registerLazySingleton<AuthenticationLocalDataSource>(
    () => AuthenticationLocalDataSourceImpl(sharedPreferences: sl()),
  );

  sl.registerLazySingleton<FilmProductionsRemoteDataSource>(
    () => FilmProductionsRemoteDataSourceImpl(client: sl()),
  );

  //! External
  sl.registerLazySingleton(() => http.Client());

  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => sharedPreferences);
}
