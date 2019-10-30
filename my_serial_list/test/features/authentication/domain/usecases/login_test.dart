import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_serial_list/features/authorization/data/models/token_model.dart';
import 'package:my_serial_list/features/authorization/domain/entities/user/authenticate_user_model.dart';
import 'package:my_serial_list/features/authorization/domain/repositories/authetication_repository.dart';
import 'package:my_serial_list/features/authorization/domain/usecases/login.dart';

class MockAutheticationRepository extends Mock
    implements AutheticationRepository {}

void main() {
  Login login;
  MockAutheticationRepository mockAutheticationRepository;

  setUp(() {
    mockAutheticationRepository = MockAutheticationRepository();
    login = Login(mockAutheticationRepository);
  });

  final AuthenticateUser authenticateUser = AuthenticateUser(
    username: "m.w@g.pl",
    password: "123",
  );
  final response = TokenModel(token: "sample token");

  test(
    'should return token if is internet or failure if no internet',
    () async {
      // arrange
      when(mockAutheticationRepository.login(any))
          .thenAnswer((_) async => Right(response));
      // act
      final result = await login(authenticateUser);
      // assert
      expect(result, Right(response));
      verify(mockAutheticationRepository.login(authenticateUser));
      verifyNoMoreInteractions(mockAutheticationRepository);
    },
  );
}