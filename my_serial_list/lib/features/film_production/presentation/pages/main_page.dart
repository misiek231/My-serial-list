import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:my_serial_list/features/film_production/presentation/widgets/list_view.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    onTabTapped(int index) {
      setState(() {
        _currentIndex = index;
      });
    }

    Widget indexToPage() {
      switch (_currentIndex) {
        case 0:
          return InfiniteListView();
        case 1:
          return InfiniteListView();
        default:
          return Text('Error');
      }
    }

    return Scaffold(
        body: indexToPage(),
        bottomNavigationBar: BottomNavyBar(
          onItemSelected: onTabTapped,
          currentIndex: _currentIndex,
          iconSize: 30,
          items: [
            BottomNavyBarItem(
              icon: Icon(Icons.view_list),
              title: Text('Moja lista'),
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.vertical_align_top),
              title: Text('Topka'),
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.settings),
              title: Text('Ustawienia'),
            ),
          ],
        ));
  }
}
