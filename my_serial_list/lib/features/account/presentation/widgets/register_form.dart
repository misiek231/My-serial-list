import 'package:flutter/material.dart';
import 'package:my_serial_list/core/constants.dart';
import 'package:my_serial_list/features/account/domain/entities/user/create_user.dart';

import 'custom_input.dart';

class RegisterForm extends StatefulWidget {
  RegisterForm({Key key}) : super(key: key);

  @override
  State<RegisterForm> createState() => RegisterFormState();
}

class RegisterFormState extends State<RegisterForm> {
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  CreateUser validate() {
    if (_formKey.currentState.validate()) {
      return CreateUser(
        username: _usernameController.text,
        email: _emailController.text,
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
              controller: _emailController,
              text: 'Email',
              obscureText: false,
              keyboardType: TextInputType.emailAddress,
              validator: (str) {
                if (str.isEmpty) {
                  return "Pole jest wymagane";
                } else if (!RegExp(emailPattern).hasMatch(str)) {
                  return 'Podaj prawidłowy adres email';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            CustomInput(
              obscureText: false,
              controller: _usernameController,
              text: "Nazwa użytkownika",
              validator: (str) {
                if (str.isEmpty) {
                  return "Pole jest wymagane";
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            CustomInput(
              controller: _passwordController,
              text: 'Hasło',
              obscureText: true,
              validator: (str) {
                if (str.isEmpty) {
                  return "Pole jest wymagane";
                } else if (str != _repeatPasswordController.text) {
                  return "Hasła są różne";
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            CustomInput(
              controller: _repeatPasswordController,
              text: 'Powtórz hasło',
              obscureText: true,
              validator: (str) {
                if (str.isEmpty) {
                  return "Pole jest wymagane";
                } else if (str != _passwordController.text) {
                  return "Hasła są różne";
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
