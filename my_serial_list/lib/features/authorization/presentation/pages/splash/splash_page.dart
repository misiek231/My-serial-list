import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_serial_list/features/authorization/presentation/bloc/authentication/authentication.dart';
import 'package:my_serial_list/features/authorization/presentation/pages/home/home_page.dart';
import 'package:my_serial_list/features/authorization/presentation/pages/login/login_page.dart';
import 'package:my_serial_list/features/authorization/presentation/pages/utils/photo_hero.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationAuthenticated) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        }
        if (state is AuthenticationUnauthenticated) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        }
      },
      child: Scaffold(
        body: Container(
            alignment: Alignment.center,
            child: PhotoHero(
              width: 200,
              photo: 'assets/icon.png',
            )),
      ),
    );
  }
}
