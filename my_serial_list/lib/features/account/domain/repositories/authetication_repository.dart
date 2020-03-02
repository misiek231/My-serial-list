import 'package:dartz/dartz.dart';
import 'package:my_serial_list/core/error/failures.dart';
import 'package:my_serial_list/features/account/domain/entities/succes_response.dart';
import 'package:my_serial_list/features/account/domain/entities/user/authenticate_user.dart';
import 'package:my_serial_list/features/account/domain/entities/user/create_user.dart';
import 'package:my_serial_list/features/account/domain/entities/user/token.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, Token>> get token;
  Future<Either<Failure, String>> get username;

  Future<Either<Failure, Token>> login(AuthenticateUser authenticateUserModel);

  Future<Either<Failure, SuccesResponse>> register(CreateUser createUserModel);

  Future<Either<Failure, SuccesResponse>> logout();
}
