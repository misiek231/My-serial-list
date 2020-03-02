import 'package:dartz/dartz.dart';
import 'package:my_serial_list/core/error/failures.dart';
import 'package:my_serial_list/core/usecases/usecase.dart';
import 'package:my_serial_list/features/account/domain/entities/succes_response.dart';
import 'package:my_serial_list/features/account/domain/repositories/authetication_repository.dart';

class Logout implements UseCase<SuccesResponse, NoParams> {
  final AuthenticationRepository repository;

  Logout(this.repository);

  @override
  Future<Either<Failure, SuccesResponse>> call(NoParams params) =>
      repository.logout();
}
