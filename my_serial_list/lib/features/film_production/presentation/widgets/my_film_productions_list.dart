import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_serial_list/core/constants.dart';
import 'package:my_serial_list/features/account/presentation/pages/authorization_page.dart';
import 'package:my_serial_list/features/film_production/presentation/bloc/my_film_productions/bloc.dart';
import 'package:my_serial_list/features/film_production/presentation/pages/film_production_page.dart';
import 'package:my_serial_list/features/film_production/presentation/widgets/error_view.dart';
import 'package:my_serial_list/features/film_production/presentation/widgets/list_element.dart';

import '../../../../injection_container.dart';
import 'infinite_list_view.dart';

class MyFilmProductionsList extends StatefulWidget {
  final WatchingStatus watchingStatus;

  MyFilmProductionsList({
    Key key,
    @required this.watchingStatus,
  }) : super(key: key);

  @override
  _MyFilmProductionsListState createState() => _MyFilmProductionsListState();
}

class _MyFilmProductionsListState extends State<MyFilmProductionsList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  MyFilmProductionsBloc bloc = sl();

  @override
  void initState() {
    super.initState();
    bloc.add(GetMoreData(widget.watchingStatus));
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: bloc,
      builder: (context, state) {
        if (state is Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is Loaded) {
          return _buildInfiniteListView(state);
        } else if (state is NotLoggedIn) {
          return Center(
            child: RaisedButton(
              child: Text('Zaloguj się'),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AuthorizationPage()));
              },
            ),
          );
        } else if (state is Empty) {
          return Center(
            child: Text(
              'Brak filmów na tej liście',
              style: TextStyle(fontSize: 20),
            ),
          );
        } else if (state is Error) {
          return ErrorView(
            message: state.message,
            reload: () => bloc.add(
              GetMoreData(widget.watchingStatus),
            ),
          );
        }
        return null;
      },
    );
  }

  Widget _buildInfiniteListView(Loaded state) {
    return InfiniteListView(
      builder: (context, model) => ListElement(model),
      hasReachedEndOfResults: state.hasReachedEndOfResults,
      items: state.filmProductions,
      getMoreDataEvent: () => bloc.add(GetMoreData(widget.watchingStatus)),
      onElementTap: (model, context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FilmProductionPage(
              filmProduction: model,
            ),
          ),
        );
      },
    );
  }
}
