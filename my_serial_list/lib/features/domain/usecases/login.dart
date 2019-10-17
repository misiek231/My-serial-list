import 'package:dartz/dartz.dart';
import 'package:my_serial_list/core/error/failures.dart';
import 'package:my_serial_list/core/usecases/usecase.dart';
import 'package:my_serial_list/features/domain/entities/user/authenticate_user_model.dart';
import 'package:my_serial_list/features/domain/entities/user/token.dart';
import 'package:my_serial_list/features/domain/repositories/authetication_repository.dart';

class Login implements UseCase<Token, AuthenticateUser> {
  final AutheticationRepository repository;

  Login(this.repository);

  @override
  Future<Either<Failure, Token>> call(AuthenticateUser params) async {
    return await repository.login(params);
  }
}
