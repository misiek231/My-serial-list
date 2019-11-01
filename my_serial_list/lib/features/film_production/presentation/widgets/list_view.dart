import 'package:floating_search_bar/ui/sliver_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_serial_list/features/film_production/presentation/bloc/top_rated/bloc.dart';
import 'package:my_serial_list/features/film_production/presentation/pages/film_production_page.dart';
import 'package:my_serial_list/features/film_production/presentation/widgets/list_element.dart';
import 'package:my_serial_list/injection_container.dart';

class InfiniteListView extends StatefulWidget {
  @override
  _InfiniteListViewState createState() => _InfiniteListViewState();
}

class _InfiniteListViewState extends State<InfiniteListView> {
  ScrollController _scrollController = new ScrollController();
  TopRatedBloc bloc = sl<TopRatedBloc>();
  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_scrollListener);
    bloc.add(GetMoreData());
  }

  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      bloc.add(GetMoreData());
    }
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  int calculateListItemCount(Loaded state) {
    if (state.hasReachedEndOfResults) {
      return state.filmProductions.length;
    } else {
      // + 1 for the loading indicator
      return state.filmProductions.length + 1;
    }
  }

  Widget _buildLoaderListItem() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildItem(int index, Loaded state) {
    if (index >= state.filmProductions.length) {
      return _buildLoaderListItem();
    } else {
      return GestureDetector(
        child: ListElement(state.filmProductions[index]),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FilmProductionPage(
                filmProductionId: state.filmProductions[index].filmProductionId,
                poster: state.filmProductions[index].poster,
              ),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: bloc,
      builder: (context, TopRatedState state) {
        if (state is Empty) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is Loaded) {
          return Padding(
            padding: EdgeInsets.only(top: 5),
            child: CustomScrollView(
              controller: _scrollController,
              slivers: <Widget>[
                SliverFloatingBar(
                  trailing: IconButton(
                    icon: Icon(Icons.supervised_user_circle),
                    onPressed: () {},
                  ),
                  floating: true,
                  title: TextField(
                    decoration: InputDecoration(hintText: 'Szukaj filmu...'),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _buildItem(index, state),
                    childCount: calculateListItemCount(state),
                  ),
                )
              ],
            ),
          );
        } else {
          return Text("error");
        }
      },
    );
  }
}
