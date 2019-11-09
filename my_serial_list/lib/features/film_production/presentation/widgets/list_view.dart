import 'package:floating_search_bar/ui/sliver_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_serial_list/features/authorization/presentation/pages/authorization_page.dart';
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
                  backgroundColor: Theme.of(context).backgroundColor,
                  trailing: IconButton(
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
                  floating: true,
                  title: TextField(
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      hintText: 'Szukaj filmu...',
                      border: InputBorder.none,
                    ),
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
