import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:my_serial_list/core/usecases/usecase.dart';
import 'package:my_serial_list/features/authorization/domain/usecases/getToken.dart';
import 'package:my_serial_list/features/authorization/domain/usecases/login.dart';
import 'package:meta/meta.dart';

import 'authentication.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final GetToken getToken;
  final Login login;
  final Register register;

  AuthenticationBloc({
    @required this.getToken,
    @required this.login,
    @required this.register,
  })  : assert(getToken != null),
        assert(login != null),
        assert(register != null);

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield Loading();

      final token = await getToken(NoParams());

      yield* token.fold(
        (failure) async* {
          yield AuthenticationUnauthenticated();
        },
        (token) async* {
          yield AuthenticationAuthenticated();
        },
      );
    }

    if (event is LogIn) {
      final result = await login(event.authenticateUser);
      result.fold((failure) async* {
        yield AuthenticationUnauthenticated();
      }, (token) async* {
        yield AuthenticationAuthenticated();
      });
    }

    if (event is LogOut) {}
  }
}
