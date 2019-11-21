import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:my_serial_list/features/account/domain/entities/user/authenticate_user.dart';
import 'package:my_serial_list/features/account/domain/entities/user/create_user.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object> get props => [];
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

class RegisterEvent extends AuthenticationEvent {
  final CreateUser createUser;

  RegisterEvent({@required this.createUser});

  @override
  List<Object> get props => [createUser];

  @override
  String toString() => 'Register';
}
