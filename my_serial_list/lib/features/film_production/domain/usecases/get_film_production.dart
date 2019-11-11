import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:my_serial_list/core/error/failures.dart';
import 'package:my_serial_list/core/usecases/usecase.dart';
import 'package:my_serial_list/features/film_production/domain/entities/film_production.dart';
import 'package:meta/meta.dart';
import 'package:my_serial_list/features/film_production/domain/repositories/film_productions_repository.dart';

class GetFilmProduction implements UseCase<FilmProduction, Params> {
  final FilmProductionsRepository repository;

  GetFilmProduction(this.repository);

  @override
  Future<Either<Failure, FilmProduction>> call(
    Params params,
  ) async {
    return await repository.getFilmProduction(params.id);
  }
}

class Params extends Equatable {
  final int id;

  Params({@required this.id});

  @override
  List<Object> get props => [id];
}
