import 'package:dartz/dartz.dart';
import 'package:my_serial_list/core/error/failures.dart';
import 'package:my_serial_list/core/usecases/usecase.dart';
import 'package:my_serial_list/features/authorization/domain/entities/user/token.dart';
import 'package:my_serial_list/features/authorization/domain/repositories/authetication_repository.dart';

class GetToken implements UseCase<Token, NoParams> {
  final AutheticationRepository repository;

  GetToken(this.repository);

  @override
  Future<Either<Failure, Token>> call(NoParams params) async {
    return await repository.token;
  }
}
