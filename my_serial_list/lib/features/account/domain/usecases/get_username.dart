import 'package:dartz/dartz.dart';
import 'package:my_serial_list/core/error/failures.dart';
import 'package:my_serial_list/core/usecases/usecase.dart';
import 'package:my_serial_list/features/account/domain/repositories/authetication_repository.dart';

class GetUsername extends UseCase<String, NoParams> {
  final AuthenticationRepository repository;

  GetUsername(this.repository);

  @override
  Future<Either<Failure, String>> call(NoParams params) => repository.username;
}
