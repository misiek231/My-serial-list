import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_serial_list/features/domain/entities/succes_response.dart';
import 'package:my_serial_list/features/domain/entities/user/create_user_model.dart';
import 'package:my_serial_list/features/domain/repositories/authetication_repository.dart';
import 'package:my_serial_list/features/domain/usecases/register.dart';

class MockAutheticationRepository extends Mock
    implements AutheticationRepository {}

void main() {
  Register register;
  MockAutheticationRepository mockAutheticationRepository;

  setUp(() {
    mockAutheticationRepository = MockAutheticationRepository();
    register = Register(mockAutheticationRepository);
  });

  final CreateUser createUser = CreateUser(
    email: "m.w@g.pl",
    username: "Michal",
    password: "123",
  );
  final response = SuccesResponse();

  test(
    'should return succes response if is internet or failure if no internet',
    () async {
      // arrange
      when(mockAutheticationRepository.register(any))
          .thenAnswer((_) async => Right(response));
      // act
      final result = await register(createUser);
      // assert
      expect(result, Right(response));
      verify(mockAutheticationRepository.register(createUser));
      verifyNoMoreInteractions(mockAutheticationRepository);
    },
  );
}
