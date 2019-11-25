import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final bool obscureText;
  final String Function(String value) validator;
  final TextInputType keyboardType;
  CustomInput({
    this.controller,
    this.text,
    this.obscureText,
    this.validator,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: text,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(),
          ),
        ),
        validator: validator,
        style: TextStyle(
          fontFamily: "Poppins",
        ),
      ),
    );
  }
}
