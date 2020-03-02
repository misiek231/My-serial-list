﻿import 'package:meta/meta.dart';

class AuthenticateUser {
  String username;
  String password;

  AuthenticateUser({
    @required this.username,
    @required this.password,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
      };
}
