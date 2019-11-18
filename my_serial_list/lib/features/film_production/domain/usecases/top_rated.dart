import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:my_serial_list/core/constants.dart';
import 'package:my_serial_list/core/error/failures.dart';
import 'package:my_serial_list/core/usecases/usecase.dart';
import 'package:my_serial_list/features/film_production/domain/entities/film_production_rating.dart';
import 'package:my_serial_list/features/film_production/domain/repositories/film_productions_repository.dart';

class TopRated implements UseCase<List<FilmProductionRating>, Params> {
  final FilmProductionsRepository repository;

  TopRated(this.repository);

  @override
  Future<Either<Failure, List<FilmProductionRating>>> call(
    Params params,
  ) async {
    return await repository.getAll(params.page, params.type, params.query);
  }
}

class Params extends Equatable {
  final int page;
  final FilmProductionType type;
  final String query;

  Params({this.page, this.type, this.query});

  @override
  List<Object> get props => [page, type];
}
