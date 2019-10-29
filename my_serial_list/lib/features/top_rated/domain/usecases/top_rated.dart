import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:my_serial_list/core/error/failures.dart';
import 'package:my_serial_list/core/usecases/usecase.dart';
import 'package:my_serial_list/features/top_rated/domain/entities/film_production_rating.dart';
import 'package:meta/meta.dart';
import 'package:my_serial_list/features/top_rated/domain/repositories/film_productions_repository.dart';

class TopRated implements UseCase<List<FilmProductionRating>, Params> {
  final FilmProductionsRepository repository;

  TopRated(this.repository);

  @override
  Future<Either<Failure, List<FilmProductionRating>>> call(
    Params params,
  ) async {
    return await repository.getTopRated(params.page);
  }
}

class Params extends Equatable {
  final int page;

  Params({@required this.page}) : super([page]);
}
