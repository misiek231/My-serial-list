import 'dart:async';

import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_serial_list/features/account/domain/entities/user/authenticate_user.dart';
import 'package:my_serial_list/features/account/domain/entities/user/create_user.dart';
import 'package:my_serial_list/features/account/presentation/bloc/authentication/authentication.dart';
import 'package:my_serial_list/features/account/presentation/widgets/button_indicator.dart';
import 'package:my_serial_list/features/account/presentation/widgets/login_form.dart';
import 'package:my_serial_list/features/account/presentation/widgets/register_form.dart';

import '../../../../injection_container.dart';

class AuthorizationPage extends StatefulWidget {
  AuthorizationPage({Key key}) : super(key: key);

  @override
  _AuthorizationPageState createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  AuthenticationBloc bloc = sl<AuthenticationBloc>();
  bool isLoginFormShowing = true;
  final _loginFormKey = GlobalKey<LoginFormState>();
  final _registerFormKey = GlobalKey<RegisterFormState>();

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logowanie'),
      ),
      body: BlocListener(
        bloc: bloc,
        listener: (context, state) {
          if (state is LoginSuccess) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                duration: Duration(seconds: 500),
                content: Txt(
                  'Pomyśnie zalogowano',
                  style: TxtStyle()
                    ..fontSize(20)
                    ..fontWeight(FontWeight.bold),
                ),
                backgroundColor: Colors.greenAccent,
              ),
            );
            Timer(
              Duration(milliseconds: 500),
              () => Navigator.pop(context),
            );
          } else if (state is LoginFailure) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                duration: Duration(seconds: 1),
                content: Txt(
                  state.message,
                  style: TxtStyle()
                    ..fontSize(20)
                    ..fontWeight(FontWeight.bold),
                ),
                backgroundColor: Colors.redAccent,
              ),
            );
          } else if (state is RegisterSuccess) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                // return object of type Dialog
                return AlertDialog(
                  title: new Text("Pomyślnie utworzono konto"),
                  content:
                      new Text("Potwierdź adres email aby móc się zalogować"),
                  actions: <Widget>[
                    FlatButton(
                      child: new Txt(
                        "OK",
                        style: TxtStyle()
                          ..fontSize(20)
                          ..textColor(Colors.blueAccent),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          } else if (state is RegisterFailure) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                duration: Duration(seconds: 4),
                content: Txt(
                  state.message,
                  style: TxtStyle()
                    ..fontSize(20)
                    ..fontWeight(FontWeight.bold),
                ),
                backgroundColor: Colors.redAccent,
              ),
            );
          }
        },
        child: Stack(
          children: <Widget>[
            Image.asset('assets/wallpaper.png',
                fit: BoxFit.fitHeight,
                height: MediaQuery.of(context).size.height),
            _buildAnimatedForm(true, isLoginFormShowing),
            _buildAnimatedForm(false, !isLoginFormShowing),
          ],
        ),
      ),
    );
  }

  AnimatedPositioned _buildAnimatedForm(bool isLoginForm, bool isShowing) {
    final width = MediaQuery.of(context).size.width;

    return AnimatedPositioned(
      curve: Curves.ease,
      top: 0,
      bottom: 0,
      left: isShowing ? 0 : isLoginForm ? -width : width,
      width: MediaQuery.of(context).size.width,
      duration: Duration(milliseconds: 500),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Card(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset(
                    'assets/spider.png',
                    height: 100,
                  ),
                  isLoginForm
                      ? LoginForm(key: _loginFormKey)
                      : RegisterForm(key: _registerFormKey),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      BlocBuilder(
                        bloc: bloc,
                        builder: (context, state) {
                          return ButtonIndicator(
                            isBusy: state is Loading,
                            text: isLoginForm ? 'Zaloguj' : 'Rejestracja',
                            onPressed: () {
                              if (isLoginForm) {
                                AuthenticateUser data =
                                    _loginFormKey.currentState.validate();
                                if (data != null)
                                  bloc.add(LogIn(authenticateUser: data));
                              } else {
                                CreateUser data =
                                    _registerFormKey.currentState.validate();
                                if (data != null)
                                  bloc.add(RegisterEvent(createUser: data));
                              }
                            },
                          );
                        },
                      ),
                      FittedBox(
                        fit: BoxFit.contain,
                        child: ButtonIndicator(
                          isBusy: false,
                          text: isLoginForm ? 'Nie mam konta' : 'Mam już konto',
                          onPressed: () {
                            setState(() {
                              isLoginFormShowing = !isLoginFormShowing;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
