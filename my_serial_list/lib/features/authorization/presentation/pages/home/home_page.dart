import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_serial_list/features/authorization/presentation/bloc/authentication/authentication.dart';
import 'package:my_serial_list/features/authorization/presentation/pages/login/login_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);

    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationUnauthenticated) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: Container(
          child: Center(
              child: RaisedButton(
            child: Text('logout'),
            onPressed: () {
              authenticationBloc.add(LogOut());
            },
          )),
        ),
      ),
    );
  }
}
