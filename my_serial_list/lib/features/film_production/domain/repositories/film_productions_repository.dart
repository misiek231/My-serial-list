import 'package:dartz/dartz.dart';
import 'package:my_serial_list/core/error/failures.dart';
import 'package:my_serial_list/features/film_production/domain/entities/film_production.dart';
import 'package:my_serial_list/features/film_production/domain/entities/film_production_rating.dart';

abstract class FilmProductionsRepository {
  Future<Either<Failure, List<FilmProductionRating>>> getTopRated(int page);

  Future<Either<Failure, FilmProduction>> getFilmProduction(int id);
}
