import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {}

class AuthenticationUninitialized extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {}

class AuthenticationUnauthenticated extends AuthenticationState {}

class Loading extends AuthenticationState {}

class RegisterFailure extends AuthenticationState {}

class RegisterSuccess extends AuthenticationState {}
