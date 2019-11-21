import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:my_serial_list/core/error/failures.dart';
import 'package:my_serial_list/features/account/domain/usecases/login.dart';
import 'package:meta/meta.dart';
import 'package:my_serial_list/features/account/domain/usecases/register.dart';

import 'authentication.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final Login login;
  final Register register;

  AuthenticationBloc({
    @required this.login,
    @required this.register,
  })  : assert(login != null),
        assert(register != null);

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is LogIn) {
      yield Loading();

      final result = await login(event.authenticateUser);

      yield* result.fold(
        (failure) async* {
          if (failure is RemoteFailure)
            yield LoginFailure(message: failure.message);
        },
        (token) async* {
          yield LoginSuccess();
        },
      );
    } else if (event is RegisterEvent) {
      yield Loading();
      final result = await register(event.createUser);

      yield* result.fold(
        (failure) async* {
          if (failure is RemoteFailure)
            yield RegisterFailure(message: failure.message);
        },
        (_) async* {
          yield RegisterSuccess();
        },
      );
    } else if (event is LogOut) {}
  }
}
