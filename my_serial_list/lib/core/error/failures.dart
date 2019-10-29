import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure([List properties = const <dynamic>[]]) : super(properties);
}

class CacheFailure extends Failure {
  CacheFailure([List properties = const <dynamic>[]]) : super(properties);
}

class RemoteFailure extends Failure {
  final String message;

  RemoteFailure({this.message}) : super([message]);
}
