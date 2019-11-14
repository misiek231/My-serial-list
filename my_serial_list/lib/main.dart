import 'package:flutter/material.dart';
import 'package:my_serial_list/injection_container.dart';

import 'core/presentation/pages/main_page.dart';

void main() async {
  init();
  runApp(App());
}

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My serial list',
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],

        // Define the default font family.
        fontFamily: 'Montserrat',
      ),
      home: MainPage(),
    );
  }
}
