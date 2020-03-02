import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:my_serial_list/core/presentation/widgets/account_button.dart';
import 'package:my_serial_list/core/presentation/widgets/bottom_navigation_bar.dart';
import 'package:my_serial_list/features/film_production/presentation/pages/search_page.dart';
import 'package:my_serial_list/features/film_production/presentation/widgets/my_film_productions_list.dart';
import 'package:my_serial_list/features/film_production/presentation/widgets/top_rated_list.dart';

import '../../constants.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    int tabs = _currentPageToTabsCount();
    if (tabs > 0) {
      return DefaultTabController(
        length: tabs,
        child: _buildScaffold(context),
      );
    } else {
      return _buildScaffold(context);
    }
  }

  Scaffold _buildScaffold(BuildContext context) {
    return Scaffold(
      body: _indexToPage(),
      appBar: _buildAppBar(context),
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: _currentIndex,
        onTabTapped: _onTabTapped,
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text("MySerialList"),
      bottom: TabBar(
        tabs: _getTabs(),
      ),
      actions: <Widget>[
        IconButton(
          padding: EdgeInsets.only(right: 10),
          icon: Icon(Icons.search),
          onPressed: () {
            showSearch(context: context, delegate: SearchPage());
          },
        ),
        AccountButton(),
      ],
    );
  }

  List<Widget> _getTabs() {
    switch (_currentIndex) {
      case 0:
        return [
          Tab(
            child: Text("Aktualnie oglądane", style: TextStyle(fontSize: 15)),
          ),
          Tab(child: Text("Planowane", style: TextStyle(fontSize: 15))),
          Tab(child: Text("Zakończone", style: TextStyle(fontSize: 15))),
        ];
      case 1:
        return [
          Tab(child: Text("Filmy", style: TextStyle(fontSize: 20))),
          Tab(child: Text("Seriale", style: TextStyle(fontSize: 20))),
        ];
    }
    return [];
  }

  int _currentPageToTabsCount() {
    switch (_currentIndex) {
      case 0:
        return 3;
      case 1:
        return 2;
    }
    return 0;
  }

  _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _indexToPage() {
    switch (_currentIndex) {
      case 0:
        return _buildMyFilmProductions();
      case 1:
        return _buildTopRated();
      default:
        return Txt(
          'Error',
          style: TxtStyle()
            ..alignment.center()
            ..fontSize(40),
        );
    }
  }

  TabBarView _buildTopRated() {
    return TabBarView(
      children: <Widget>[
        TopRatedList(
          filmProductionType: FilmProductionType.films,
        ),
        TopRatedList(
          filmProductionType: FilmProductionType.serials,
        ),
      ],
    );
  }

  TabBarView _buildMyFilmProductions() {
    return TabBarView(
      children: <Widget>[
        MyFilmProductionsList(
          watchingStatus: WatchingStatus.current,
        ),
        MyFilmProductionsList(
          watchingStatus: WatchingStatus.plan,
        ),
        MyFilmProductionsList(
          watchingStatus: WatchingStatus.finished,
        ),
      ],
    );
  }
}
