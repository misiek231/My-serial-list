import 'package:flutter/material.dart';

import 'custom_input.dart';

class RegisterForm extends StatefulWidget {
  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: <Widget>[
          CustomInput(
            controller: _passwordController,
            text: 'Email',
            obscureText: true,
          ),
          SizedBox(height: 20),
          CustomInput(
            obscureText: false,
            controller: _emailController,
            text: "Nazwa użytkownika",
          ),
          SizedBox(height: 20),
          CustomInput(
            controller: _passwordController,
            text: 'Hasło',
            obscureText: true,
          ),
          SizedBox(height: 20),
          CustomInput(
            controller: _passwordController,
            text: 'Powtórz hasło',
            obscureText: true,
          ),
        ],
      ),
    );
  }
}
