import 'package:dartz/dartz.dart';
import 'package:my_serial_list/core/error/failures.dart';
import 'package:my_serial_list/features/top_rated/domain/entities/film_production_rating.dart';

abstract class FilmProductionsRepository {
  Future<Either<Failure, List<FilmProductionRating>>> getTopRated(int page);
}
