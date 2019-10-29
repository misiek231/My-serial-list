import 'package:flutter/material.dart';
import 'package:my_serial_list/features/top_rated/presentation/pages/top_rated_page.dart';
import 'package:my_serial_list/injection_container.dart';

void main() async {
  init();
  runApp(App());
}

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Trivia',
      theme: ThemeData(
        primaryColor: Colors.green.shade800,
        accentColor: Colors.green.shade600,
      ),
      home: TopRatedPage(),
    );
  }
}
