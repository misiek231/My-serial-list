import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:my_serial_list/core/error/failures.dart';
import 'package:my_serial_list/core/usecases/usecase.dart';
import 'package:my_serial_list/features/film_production/domain/entities/comment.dart';
import 'package:meta/meta.dart';
import 'package:my_serial_list/features/film_production/domain/repositories/film_productions_repository.dart';

class GetComments implements UseCase<List<Comment>, Params> {
  final FilmProductionsRepository repository;

  GetComments(this.repository);

  @override
  Future<Either<Failure, List<Comment>>> call(
    Params params,
  ) async {
    return await repository.getComments(params.id);
  }
}

class Params extends Equatable {
  final int id;

  Params({@required this.id});

  @override
  List<Object> get props => [id];
}
