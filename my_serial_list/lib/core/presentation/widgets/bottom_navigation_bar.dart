import 'package:flutter/material.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final Function(int) onTabTapped;
  final int currentIndex;
  const AppBottomNavigationBar({
    Key key,
    @required this.onTabTapped,
    @required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: onTabTapped,
      currentIndex: currentIndex,
      iconSize: 30,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.view_list),
          title: Text('Moja lista'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.vertical_align_top),
          title: Text('Topka'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          title: Text('Ustawienia'),
        ),
      ],
    );
  }
}
