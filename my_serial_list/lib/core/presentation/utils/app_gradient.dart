import 'package:flutter/material.dart';

class AppGradient extends LinearGradient {
  AppGradient()
      : super(begin: Alignment.topRight, end: Alignment.bottomLeft, stops: [
          0,
          1
        ], colors: [
          Color(0xFF414345),
          Color(0xFF232526),
        ]);
}
