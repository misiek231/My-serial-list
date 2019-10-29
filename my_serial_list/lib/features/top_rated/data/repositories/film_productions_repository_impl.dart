import 'package:dartz/dartz.dart';
import 'package:my_serial_list/core/error/exceptions.dart';
import 'package:my_serial_list/core/error/failures.dart';
import 'package:meta/meta.dart';
import 'package:my_serial_list/features/top_rated/data/datasources/film_productions_remote_data_source.dart';
import 'package:my_serial_list/features/top_rated/domain/entities/film_production_rating.dart';
import 'package:my_serial_list/features/top_rated/domain/repositories/film_productions_repository.dart';

class FilmProductionsRepositoryImpl implements FilmProductionsRepository {
  final FilmProductionsRemoteDataSource remoteDataSource;

  FilmProductionsRepositoryImpl({@required this.remoteDataSource});

  @override
  Future<Either<Failure, List<FilmProductionRating>>> getTopRated(
      int page) async {
    try {
      return Right(await remoteDataSource.getTopRated(page));
    } on ServerException catch (e) {
      return Left(RemoteFailure(message: e.message));
    }
  }
}
