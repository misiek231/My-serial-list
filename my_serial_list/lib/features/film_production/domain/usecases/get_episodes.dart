import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:my_serial_list/core/error/failures.dart';
import 'package:my_serial_list/core/usecases/usecase.dart';
import 'package:my_serial_list/features/film_production/domain/entities/episode.dart';
import 'package:meta/meta.dart';
import 'package:my_serial_list/features/film_production/domain/repositories/film_productions_repository.dart';

class GetEpisodes implements UseCase<List<Episode>, Params> {
  final FilmProductionsRepository repository;

  GetEpisodes(this.repository);

  @override
  Future<Either<Failure, List<Episode>>> call(
    Params params,
  ) async {
    return await repository.getEpisodes(params.filmProductionId, params.season);
  }
}

class Params extends Equatable {
  final int filmProductionId;
  final int season;

  Params({
    @required this.filmProductionId,
    @required this.season,
  });

  @override
  List<Object> get props => [filmProductionId, season];
}
