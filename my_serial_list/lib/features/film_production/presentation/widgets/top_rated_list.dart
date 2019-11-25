import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_serial_list/core/constants.dart';
import 'package:my_serial_list/features/film_production/presentation/bloc/top_rated/bloc.dart';
import 'package:my_serial_list/features/film_production/presentation/pages/film_production_page.dart';
import 'package:my_serial_list/features/film_production/presentation/widgets/infinite_list_view.dart';
import 'package:my_serial_list/features/film_production/presentation/widgets/list_element.dart';
import 'package:my_serial_list/injection_container.dart';

import 'error_view.dart';

class TopRatedList extends StatefulWidget {
  final FilmProductionType filmProductionType;
  final String query;

  const TopRatedList({
    Key key,
    @required this.filmProductionType,
    this.query,
  }) : super(key: key);

  @override
  _TopRatedListState createState() => _TopRatedListState();
}

class _TopRatedListState extends State<TopRatedList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  TopRatedBloc bloc = sl<TopRatedBloc>();

  @override
  void initState() {
    super.initState();
    bloc.add(GetMoreData(widget.filmProductionType, widget.query));
  }

  @override
  void didUpdateWidget(TopRatedList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.query != widget.query)
      bloc.add(
        GetMoreData(
          widget.filmProductionType,
          widget.query,
          resetPages: true,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder(
      bloc: bloc,
      builder: (context, TopRatedState state) {
        if (state is Loading) {
          return _buildLoader();
        } else if (state is Empty) {
          return Txt(
            'Brak wyników!',
            style: TxtStyle()
              ..alignment.center()
              ..fontSize(20)
              ..textColor(Colors.white),
          );
        } else if (state is Loaded) {
          return _buildInfiniteListView(state);
        } else if (state is Error) {
          return _buildErrorView(state);
        }
        return Text("error");
      },
    );
  }

  Widget _buildLoader() {
    return Parent(
      child: CircularProgressIndicator(),
      style: ParentStyle()
        ..alignment.center()
        ..padding(all: 10),
    );
  }

  Widget _buildInfiniteListView(Loaded state) {
    return InfiniteListView(
      builder: (context, model) => ListElement(model),
      hasReachedEndOfResults: state.hasReachedEndOfResults,
      items: state.filmProductions,
      getMoreDataEvent: () =>
          bloc.add(GetMoreData(widget.filmProductionType, widget.query)),
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

  Widget _buildErrorView(Error state) {
    return ErrorView(
      message: state.message,
      reload: () =>
          bloc.add(GetMoreData(widget.filmProductionType, widget.query)),
    );
  }
}
