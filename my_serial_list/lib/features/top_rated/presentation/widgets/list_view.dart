import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_serial_list/features/top_rated/presentation/bloc/bloc.dart';
import 'package:my_serial_list/features/top_rated/presentation/widgets/list_element.dart';
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
    bloc.dispatch(GetMoreData());
  }

  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      bloc.dispatch(GetMoreData());
    }
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

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Color(0xff001119),
      child: BlocBuilder(
        bloc: bloc,
        builder: (context, TopRatedState state) {
          if (state is Empty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is Loaded) {
            return NotificationListener<ScrollNotification>(
              child: ListView.builder(
                itemCount: calculateListItemCount(state),
                controller: _scrollController,
                itemBuilder: (context, index) {
                  return index >= state.filmProductions.length
                      ? _buildLoaderListItem()
                      : ListElement(state.filmProductions[index]);
                },
              ),
            );
          } else {
            return Text("error");
          }
        },
      ),
    );
  }
}
