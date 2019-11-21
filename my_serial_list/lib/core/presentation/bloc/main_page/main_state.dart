import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class MainState extends Equatable {
  @override
  List<Object> get props => [];
}

class Loading extends MainState {}

class LoggedIn extends MainState {
  final String username;

  LoggedIn({@required this.username});

  @override
  List<Object> get props => [username];
}

class LoggedOut extends MainState {}
