import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_serial_list/core/presentation/bloc/main_page/main.dart';
import 'package:my_serial_list/features/account/presentation/pages/account_page.dart';
import 'package:my_serial_list/features/account/presentation/pages/authorization_page.dart';

import '../../../injection_container.dart';

class AccountButton extends StatefulWidget {
  AccountButton({Key key}) : super(key: key);

  @override
  _AccountButtonState createState() => _AccountButtonState();
}

class _AccountButtonState extends State<AccountButton> {
  final MainBloc mainBloc = sl();

  @override
  void initState() {
    mainBloc.add(IsLoggedIn());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: mainBloc,
      builder: (context, state) {
        Widget icon;
        Widget pageRoute;
        if (state is LoggedIn) {
          icon = _buildCircleAvatar(context, state.username);
          pageRoute = AccountPage();
        } else if (state is LoggedOut) {
          icon = Icon(Icons.account_circle);
          pageRoute = AuthorizationPage();
        }
        if (state is Loading) {
          icon = Center(child: CircularProgressIndicator());
          pageRoute = null;
        }
        return IconButton(
          padding: const EdgeInsets.only(right: 20),
          icon: icon,
          onPressed: () {
            if (pageRoute != null)
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => pageRoute,
                ),
              ).then((_) {
                mainBloc.add(IsLoggedIn());
              });
          },
        );
      },
    );
  }

  Widget _buildCircleAvatar(BuildContext context, String username) {
    return CircleAvatar(
      backgroundColor: Theme.of(context).accentColor,
      child: Text(
        username[0],
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
