import 'package:flutter/material.dart';
import 'package:my_serial_list/features/authorization/presentation/widgets/button_indicator.dart';
import 'package:my_serial_list/features/authorization/presentation/widgets/login_form.dart';
import 'package:my_serial_list/features/authorization/presentation/widgets/register_form.dart';

class AuthorizationPage extends StatefulWidget {
  AuthorizationPage({Key key}) : super(key: key);

  @override
  _AuthorizationPageState createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  bool isLoginFormShowing = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logowanie'),
      ),
      body: Stack(
        children: <Widget>[
          Image.asset('assets/wallpaper.png',
              fit: BoxFit.fitHeight, height: MediaQuery.of(context).size.height),
          _buildAnimatedForm(true, isLoginFormShowing),
          _buildAnimatedForm(false, !isLoginFormShowing),
        ],
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
                  isLoginForm ? LoginForm() : RegisterForm(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ButtonIndicator(
                        isBusy: false,
                        text: isLoginForm ? 'Zaloguj' : 'Rejestracja',
                        onPressed: () {},
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
