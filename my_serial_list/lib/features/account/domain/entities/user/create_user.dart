import 'package:meta/meta.dart';

class CreateUser {
  String password;
  String username;
  String email;

  CreateUser({
    @required this.password,
    @required this.username,
    @required this.email,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'username': username,
        'password': password,
      };
}
