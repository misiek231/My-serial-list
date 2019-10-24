import 'package:flutter/material.dart';
import 'package:my_serial_list/core/presentation/utils/app_gradient.dart';
import 'package:my_serial_list/features/top_rated/presentation/pages/top_rated_page.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget _buildItem({String text, IconData icon, Widget page}) {
      return Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: ListTile(
            title: Text(
              text,
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
            leading: Icon(
              icon,
              size: 30,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => page));
            }),
      );
    }

    return Drawer(
      child: Container(
        decoration: BoxDecoration(gradient: AppGradient()),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Image.asset('assets/read.png'),
              padding: EdgeInsets.all(30),
            ),
            _buildItem(
                icon: Icons.vertical_align_top,
                page: TopRatedPage(),
                text: "Top seriale i filmy"),
            _buildItem(
                icon: Icons.view_list,
                page: TopRatedPage(),
                text: "Moja lista"),
            _buildItem(
                icon: Icons.input, page: TopRatedPage(), text: "Zaloguj"),
            _buildItem(
                icon: Icons.close, page: TopRatedPage(), text: "Wyloguj"),
          ],
        ),
      ),
    );
  }
}
