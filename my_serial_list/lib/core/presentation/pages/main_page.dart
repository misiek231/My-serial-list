import 'package:flutter/material.dart';
import 'package:my_serial_list/features/authorization/presentation/pages/authorization_page.dart';
import 'package:my_serial_list/features/film_production/presentation/pages/search_page.dart';
import 'package:my_serial_list/features/film_production/presentation/widgets/list_view.dart';

import '../../constants.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          body: _indexToPage(),
          appBar: AppBar(
            title: Text("MySerialList"),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(child: Text("Filmy", style: TextStyle(fontSize: 20))),
                Tab(child: Text("Seriale", style: TextStyle(fontSize: 20))),
              ],
            ),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    showSearch(context: context, delegate: SearchPage());
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: IconButton(
                  icon: CircleAvatar(
                    backgroundColor: Theme.of(context).accentColor,
                    child: Text(
                      'M',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AuthorizationPage(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: _onTabTapped,
            currentIndex: _currentIndex,
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
          )),
    );
  }

  _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _indexToPage() {
    switch (_currentIndex) {
      case 0:
        return InfiniteListView(
          filmProductionType: FilmProductionType.all,
        );
      case 1:
        return TabBarView(
          children: <Widget>[
            InfiniteListView(
              filmProductionType: FilmProductionType.films,
            ),
            InfiniteListView(
              filmProductionType: FilmProductionType.serials,
            ),
          ],
        );
      default:
        return Center(
            child: Text(
          'Error',
          style: TextStyle(fontSize: 40),
        ));
    }
  }
}
