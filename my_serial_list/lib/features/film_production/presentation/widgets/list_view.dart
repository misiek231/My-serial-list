import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_serial_list/core/constants.dart';
import 'package:my_serial_list/features/film_production/presentation/bloc/top_rated/bloc.dart';
import 'package:my_serial_list/features/film_production/presentation/pages/film_production_page.dart';
import 'package:my_serial_list/features/film_production/presentation/widgets/list_element.dart';
import 'package:my_serial_list/injection_container.dart';

import 'error_view.dart';

class InfiniteListView extends StatefulWidget {
  final FilmProductionType filmProductionType;
  final String query;

  const InfiniteListView({
    Key key,
    @required this.filmProductionType,
    this.query,
  }) : super(key: key);

  @override
  _InfiniteListViewState createState() => _InfiniteListViewState();
}

class _InfiniteListViewState extends State<InfiniteListView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  ScrollController _scrollController = ScrollController();
  TopRatedBloc bloc = sl<TopRatedBloc>();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    bloc.add(GetMoreData(widget.filmProductionType, widget.query));
  }

  @override
  void didUpdateWidget(InfiniteListView oldWidget) {
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

  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      bloc.add(GetMoreData(widget.filmProductionType, widget.query));
    }
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  int calculateListItemCount(Loaded state) {
    return state.filmProductions.length +
        (state.hasReachedEndOfResults ? 0 : 1);
  }

  Widget _buildLoader() {
    return Parent(
      child: CircularProgressIndicator(),
      style: ParentStyle()
        ..alignment.center()
        ..padding(all: 10),
    );
  }

  Widget _buildItem(int index, Loaded state) {
    if (index >= state.filmProductions.length) {
      return _buildLoader();
    } else {
      return GestureDetector(
        child: ListElement(state.filmProductions[index]),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FilmProductionPage(
                filmProduction: state.filmProductions[index],
              ),
            ),
          );
        },
      );
    }
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
          return ListView.builder(
            controller: _scrollController,
            itemBuilder: (context, index) => _buildItem(index, state),
            itemCount: calculateListItemCount(state),
          );
        } else if (state is Error) {
          return ErrorView(
            message: state.message,
            reload: () =>
                bloc.add(GetMoreData(widget.filmProductionType, widget.query)),
          );
        }
        return Text("error");
      },
    );
  }
}
