import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationUninitialized extends AuthenticationState {}

class LoginSuccess extends AuthenticationState {}

class LoginFailure extends AuthenticationState {
  final message;

  LoginFailure({this.message});

  @override
  List<Object> get props => [message];
}

class Loading extends AuthenticationState {}

class RegisterFailure extends AuthenticationState {
  final message;

  RegisterFailure({this.message});

  @override
  List<Object> get props => [message];
}

class RegisterSuccess extends AuthenticationState {}
