import 'package:flutter/material.dart';
import 'package:my_serial_list/core/constants.dart';
import 'package:my_serial_list/features/film_production/presentation/widgets/top_rated_list.dart';

class SearchPage extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context);
  }

  @override
  Widget buildResults(BuildContext context) {
    return TopRatedList(
      filmProductionType: FilmProductionType.all,
      query: query,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return TopRatedList(
      filmProductionType: FilmProductionType.all,
      query: query,
    );
  }
}
