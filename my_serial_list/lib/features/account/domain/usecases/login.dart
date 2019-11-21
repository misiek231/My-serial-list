import 'package:dartz/dartz.dart';
import 'package:my_serial_list/core/error/failures.dart';
import 'package:my_serial_list/core/usecases/usecase.dart';
import 'package:my_serial_list/features/account/domain/entities/user/authenticate_user.dart';
import 'package:my_serial_list/features/account/domain/entities/user/token.dart';
import 'package:my_serial_list/features/account/domain/repositories/authetication_repository.dart';

class Login implements UseCase<Token, AuthenticateUser> {
  final AuthenticationRepository repository;

  Login(this.repository);

  @override
  Future<Either<Failure, Token>> call(AuthenticateUser params) =>
      repository.login(params);
}
