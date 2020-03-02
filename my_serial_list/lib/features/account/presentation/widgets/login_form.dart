import 'package:flutter/material.dart';
import 'package:my_serial_list/features/account/domain/entities/user/authenticate_user.dart';

import 'custom_input.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key key}) : super(key: key);

  @override
  State<LoginForm> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  AuthenticateUser validate() {
    if (_formKey.currentState.validate()) {
      return AuthenticateUser(
        username: _usernameController.text,
        password: _passwordController.text,
      );
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: <Widget>[
            CustomInput(
              obscureText: false,
              controller: _usernameController,
              text: "Nazwa użytkownika",
            ),
            SizedBox(height: 20),
            CustomInput(
              controller: _passwordController,
              text: 'Hasło',
              obscureText: true,
            ),
          ],
        ),
      ),
    );
  }
}
