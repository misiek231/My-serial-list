import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:my_serial_list/core/usecases/usecase.dart';
import 'package:my_serial_list/features/account/domain/usecases/get_token.dart';
import 'package:meta/meta.dart';
import 'package:my_serial_list/features/account/domain/usecases/get_username.dart';

import 'main.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final GetToken getToken;
  final GetUsername getUsername;

  MainBloc({
    @required this.getToken,
    @required this.getUsername,
  })  : assert(getToken != null),
        assert(getUsername != null);

  @override
  MainState get initialState => Loading();

  @override
  Stream<MainState> mapEventToState(
    MainEvent event,
  ) async* {
    if (event is IsLoggedIn) {
      final token = await getToken(NoParams());
      final username = await getUsername(NoParams());

      if (token.isRight() && username.isRight())
        yield LoggedIn(username: username.getOrElse(null));
      else
        yield LoggedOut();
    }
  }
}
