import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_serial_list/core/presentation/bloc/main_page/main.dart';
import 'package:my_serial_list/core/usecases/usecase.dart';
import 'package:my_serial_list/features/account/domain/usecases/get_username.dart';
import 'package:my_serial_list/features/account/presentation/pages/account_page.dart';
import 'package:my_serial_list/features/account/presentation/pages/authorization_page.dart';
import 'package:my_serial_list/features/film_production/presentation/pages/search_page.dart';
import 'package:my_serial_list/features/film_production/presentation/widgets/list_view.dart';
import 'package:my_serial_list/injection_container.dart';

import '../../constants.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 1;
  MainBloc mainBloc = sl();

  @override
  void initState() {
    mainBloc.add(IsLoggedIn());
    super.initState();
  }

  @override
  void dispose() {
    mainBloc.close();
    super.dispose();
  }

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
              IconButton(
                padding: EdgeInsets.only(right: 10),
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(context: context, delegate: SearchPage());
                },
              ),
              _buildAccountButton(context),
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

  Widget _buildAccountButton(BuildContext context) {
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
        return Txt(
          'Error',
          style: TxtStyle()
            ..alignment.center()
            ..fontSize(40),
        );
    }
  }
}
