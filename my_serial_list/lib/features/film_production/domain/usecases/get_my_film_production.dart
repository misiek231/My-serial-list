import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:my_serial_list/core/constants.dart';
import 'package:my_serial_list/core/error/failures.dart';
import 'package:my_serial_list/core/usecases/usecase.dart';
import 'package:meta/meta.dart';
import 'package:my_serial_list/features/film_production/domain/entities/film_production_rating.dart';
import 'package:my_serial_list/features/film_production/domain/repositories/film_productions_repository.dart';

class GetMyFilmProductions
    implements UseCase<List<FilmProductionRating>, Params> {
  final FilmProductionsRepository repository;

  GetMyFilmProductions(this.repository);

  @override
  Future<Either<Failure, List<FilmProductionRating>>> call(
    Params params,
  ) async {
    return await repository.getMyFilmProductions(
        params.watchingStatus, params.page);
  }
}

class Params extends Equatable {
  final WatchingStatus watchingStatus;
  final int page;

  Params({
    @required this.watchingStatus,
    this.page = 1,
  });

  @override
  List<Object> get props => [watchingStatus, page];
}
