import 'package:dartz/dartz.dart';
import 'package:my_serial_list/core/error/failures.dart';
import 'package:my_serial_list/core/usecases/usecase.dart';
import 'package:my_serial_list/features/account/domain/entities/user/token.dart';
import 'package:my_serial_list/features/account/domain/repositories/authetication_repository.dart';

class GetToken implements UseCase<Token, NoParams> {
  final AuthenticationRepository repository;

  GetToken(this.repository);

  @override
  Future<Either<Failure, Token>> call(NoParams params) => repository.token;
}
