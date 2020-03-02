import 'package:dartz/dartz.dart';
import 'package:my_serial_list/core/error/exceptions.dart';
import 'package:my_serial_list/core/error/failures.dart';
import 'package:my_serial_list/features/account/data/datasources/authentication_local_datasource.dart';
import 'package:my_serial_list/features/account/data/datasources/authentication_remote_datasource.dart';
import 'package:my_serial_list/features/account/domain/entities/succes_response.dart';
import 'package:my_serial_list/features/account/domain/entities/user/authenticate_user.dart';
import 'package:my_serial_list/features/account/domain/entities/user/create_user.dart';
import 'package:my_serial_list/features/account/domain/entities/user/token.dart';
import 'package:my_serial_list/features/account/domain/repositories/authetication_repository.dart';
import 'package:meta/meta.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationRemoteDataSource authenticationRemoteDataSource;
  final AuthenticationLocalDataSource authenticationLocalDataSource;

  AuthenticationRepositoryImpl({
    @required this.authenticationRemoteDataSource,
    @required this.authenticationLocalDataSource,
  });

  @override
  Future<Either<Failure, Token>> login(
      AuthenticateUser authenticateUserModel) async {
    try {
      final token =
          await authenticationRemoteDataSource.login(authenticateUserModel);
      await authenticationLocalDataSource.cacheToken(token);
      await authenticationLocalDataSource
          .cacheUsername(authenticateUserModel.username);
      return Right(token);
    } on ServerException catch (e) {
      return Left(RemoteFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, SuccesResponse>> register(
      CreateUser createUserModel) async {
    try {
      await authenticationRemoteDataSource.register(createUserModel);
      return Right(SuccesResponse());
    } on ServerException catch (e) {
      return Left(RemoteFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Token>> get token async {
    try {
      return Right(await authenticationLocalDataSource.getToken());
    } catch (_) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> get username async {
    try {
      return Right(await authenticationLocalDataSource.getUsername());
    } catch (_) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, SuccesResponse>> logout() async {
    try {
      await authenticationLocalDataSource.removeTokenAndUsername();
      return Right(SuccesResponse());
    } catch (_) {
      return Left(CacheFailure());
    }
  }
}
