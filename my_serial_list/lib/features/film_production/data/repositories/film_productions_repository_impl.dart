import 'package:dartz/dartz.dart';
import 'package:my_serial_list/core/constants.dart';
import 'package:my_serial_list/core/error/exceptions.dart';
import 'package:my_serial_list/core/error/failures.dart';
import 'package:meta/meta.dart';
import 'package:my_serial_list/features/film_production/data/datasources/film_productions_remote_data_source.dart';
import 'package:my_serial_list/features/film_production/domain/entities/comment.dart';
import 'package:my_serial_list/features/film_production/domain/entities/episode.dart';
import 'package:my_serial_list/features/film_production/domain/entities/film_production.dart';
import 'package:my_serial_list/features/film_production/domain/entities/film_production_rating.dart';
import 'package:my_serial_list/features/film_production/domain/repositories/film_productions_repository.dart';

class FilmProductionsRepositoryImpl implements FilmProductionsRepository {
  final FilmProductionsRemoteDataSource remoteDataSource;

  FilmProductionsRepositoryImpl({@required this.remoteDataSource});

  @override
  Future<Either<Failure, List<FilmProductionRating>>> getAll(
    int page,
    FilmProductionType type,
    String query,
  ) async {
    try {
      return Right(await remoteDataSource.getAll(page, type, query));
    } on ServerException catch (e) {
      return Left(RemoteFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, FilmProduction>> getFilmProduction(int id) async {
    try {
      return Right(await remoteDataSource.getFilmProduction(id));
    } on ServerException catch (e) {
      return Left(RemoteFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<Comment>>> getComments(int id) async {
    try {
      return Right(await remoteDataSource.getComments(id));
    } on ServerException catch (e) {
      return Left(RemoteFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<Episode>>> getEpisodes(
      int filmProductionId, int season) async {
    try {
      return Right(
          await remoteDataSource.getEpisodes(filmProductionId, season));
    } on ServerException catch (e) {
      return Left(RemoteFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<FilmProductionRating>>> getMyFilmProductions(
      WatchingStatus watchingStatus, int page) async {
    try {
      return Right(
          await remoteDataSource.getMyFilmProductions(watchingStatus, page));
    } on ServerException catch (e) {
      return Left(RemoteFailure(message: e.message));
    } on NoAuthorizationException {
      return Left(NoAuthorizationFailure());
    }
  }
}
