import 'package:dartz/dartz.dart';
import 'package:my_serial_list/core/constants.dart';
import 'package:my_serial_list/core/error/failures.dart';
import 'package:my_serial_list/features/film_production/domain/entities/comment.dart';
import 'package:my_serial_list/features/film_production/domain/entities/episode.dart';
import 'package:my_serial_list/features/film_production/domain/entities/film_production.dart';
import 'package:my_serial_list/features/film_production/domain/entities/film_production_rating.dart';

abstract class FilmProductionsRepository {
  Future<Either<Failure, List<FilmProductionRating>>> getAll(
    int page,
    FilmProductionType type,
    String query,
  );

  Future<Either<Failure, FilmProduction>> getFilmProduction(int id);

  Future<Either<Failure, List<Comment>>> getComments(int id);

  Future<Either<Failure, List<Episode>>> getEpisodes(
      int filmProductionId, int season);

  Future<Either<Failure, List<FilmProductionRating>>> getMyFilmProductions(
      WatchingStatus watchingStatus, int page);
}
