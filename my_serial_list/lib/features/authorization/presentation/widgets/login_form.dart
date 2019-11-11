import 'package:flutter/material.dart';

import 'custom_input.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: <Widget>[
          CustomInput(
            obscureText: false,
            controller: _emailController,
            text: "Podaj email",
          ),
          SizedBox(height: 20),
          CustomInput(
            controller: _passwordController,
            text: 'Podaj hasło',
            obscureText: true,
          ),
        ],
      ),
    );
  }
}
