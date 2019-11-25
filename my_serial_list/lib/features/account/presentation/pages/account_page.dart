import 'package:flutter/material.dart';
import 'package:my_serial_list/core/usecases/usecase.dart';
import 'package:my_serial_list/features/account/domain/usecases/logout.dart';

import '../../../../injection_container.dart';

class AccountPage extends StatelessWidget {
  AccountPage({Key key}) : super(key: key);
  final Logout logout = sl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Moje konto"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            logout(NoParams());
            Navigator.of(context).pop();
          },
          child: Text("Wyloguj"),
        ),
      ),
    );
  }
}
