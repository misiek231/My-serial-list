import 'package:dartz/dartz.dart';
import 'package:my_serial_list/core/error/failures.dart';
import 'package:my_serial_list/features/authorization/domain/entities/succes_response.dart';
import 'package:my_serial_list/features/authorization/domain/entities/user/authenticate_user_model.dart';
import 'package:my_serial_list/features/authorization/domain/entities/user/create_user_model.dart';
import 'package:my_serial_list/features/authorization/domain/entities/user/token.dart';

abstract class AutheticationRepository {
  Future<Either<Failure, Token>> get token;

  Future<Either<Failure, Token>> login(AuthenticateUser authenticateUserModel);

  Future<Either<Failure, SuccesResponse>> register(CreateUser createUserModel);
}
