import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:my_serial_list/features/authorization/domain/entities/user/authenticate_user_model.dart';
import 'package:my_serial_list/features/authorization/domain/entities/user/create_user_model.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';
}

class LogIn extends AuthenticationEvent {
  final AuthenticateUser authenticateUser;

  LogIn({@required this.authenticateUser});

  @override
  List<Object> get props => [authenticateUser];
}

class LogOut extends AuthenticationEvent {
  @override
  String toString() => 'LoggedOut';
}

class Register extends AuthenticationEvent {
  final CreateUser createUser;

  Register({@required this.createUser});

  @override
  List<Object> get props => [createUser];

  @override
  String toString() => 'Register';
}
