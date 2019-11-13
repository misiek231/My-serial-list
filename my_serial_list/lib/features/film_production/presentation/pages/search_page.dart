import 'package:flutter/material.dart';
import 'package:my_serial_list/features/film_production/presentation/bloc/film_production/bloc.dart';
import '../../../../injection_container.dart';

class SearchPage extends StatefulWidget {
  SearchPage({
    Key key,
  }) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  FilmProductionBloc bloc = sl<FilmProductionBloc>();
  List<Widget> seasonViews;

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wyszukaj"),
      ),
      body: Center(
        child: Text("TODO: Create view"),
      ),
    );
  }
}
