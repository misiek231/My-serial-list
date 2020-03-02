import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_serial_list/features/film_production/domain/entities/film_production.dart';
import 'package:my_serial_list/features/film_production/domain/entities/film_production_rating.dart';
import 'package:my_serial_list/features/film_production/presentation/bloc/film_production/bloc.dart';
import 'package:my_serial_list/features/film_production/presentation/utils/film_production_sliver_header_delegate.dart';
import 'package:my_serial_list/features/film_production/presentation/widgets/adding_fab_button.dart';
import 'package:my_serial_list/features/film_production/presentation/widgets/error_view.dart';
import 'package:my_serial_list/features/film_production/presentation/widgets/film_production_details.dart';
import 'package:my_serial_list/features/film_production/presentation/widgets/season_view.dart';
import '../../../../injection_container.dart';
import 'package:meta/meta.dart';

class FilmProductionPage extends StatefulWidget {
  final FilmProductionRating filmProduction;
  FilmProductionPage({
    Key key,
    @required this.filmProduction,
  }) : super(key: key);

  @override
  _FilmProductionPageState createState() => _FilmProductionPageState();
}

class _FilmProductionPageState extends State<FilmProductionPage>
    with SingleTickerProviderStateMixin {
  final FilmProductionBloc bloc = sl<FilmProductionBloc>();
  List<Widget> seasonViews;
  ScrollController _hideButtonController;
  bool _isVisible = true;
  TabController _tabController;

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(
        vsync: this, length: widget.filmProduction.seasons + 1);
    bloc.add(GetData(widget.filmProduction.filmProductionId));
    _hideButtonController = new ScrollController();

    if (widget.filmProduction.currentUserItem) {
      _isVisible = false;
    } else
      _hideButtonController.addListener(() {
        if (_hideButtonController.position.userScrollDirection ==
            ScrollDirection.reverse) {
          if (_isVisible == true) {
            setState(() {
              _isVisible = false;
            });
          }
        } else {
          if (_isVisible == false) {
            setState(() {
              _isVisible = true;
            });
          }
        }
      });

    if (widget.filmProduction.isSeries) {
      seasonViews = List.generate(
        widget.filmProduction.seasons,
        (index) => SeasonView(
          season: index + 1,
          filmProductionId: widget.filmProduction.filmProductionId,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.filmProduction.isSeries) {
      return DefaultTabController(
        length: widget.filmProduction.seasons + 1,
        child: _buildScaffold(),
      );
    } else {
      return _buildScaffold();
    }
  }

  Widget _buildScaffold() {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.filmProduction.title),
        bottom: widget.filmProduction.isSeries ? _buildTabBar() : null,
      ),
      floatingActionButton: AddingFabButton(
        visible: _isVisible,
        filmProduction: widget.filmProduction,
        refresh: () =>
            bloc.add(GetData(widget.filmProduction.filmProductionId)),
        navigateToTab: () => _tabController.animateTo(1),
      ),
      body: BlocBuilder<FilmProductionBloc, FilmProductionState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is InitialFilmProductionState) {
            return _buildProgressIndicator();
          } else if (state is Loaded) {
            return widget.filmProduction.isSeries
                ? _buildTabBarView(context, state)
                : _buildCustomScrollView(context, state);
          } else if (state is Error) {
            return ErrorView(
              message: state.error,
              reload: () => bloc.add(
                GetData(widget.filmProduction.filmProductionId),
              ),
            );
          }
          return null;
        },
      ),
    );
  }

  TabBarView _buildTabBarView(BuildContext context, Loaded state) {
    List<Widget> a = [
      _buildCustomScrollView(context, state),
    ];
    a.addAll(seasonViews);
    return TabBarView(controller: _tabController, children: a);
  }

  TabBar _buildTabBar() {
    return TabBar(
      isScrollable: true,
      controller: _tabController,
      tabs: List.generate(
        widget.filmProduction.seasons + 1,
        (index) {
          return Tab(
            text: index == 0 ? 'Informacje' : 'Sezon $index',
          );
        },
      ),
    );
  }

  CustomScrollView _buildCustomScrollView(BuildContext context, Loaded state) {
    return CustomScrollView(
      controller: _hideButtonController,
      slivers: <Widget>[
        _buildHeader(context, state.filmProduction),
        FilmProductionDetails(model: state.filmProduction),
      ],
    );
  }

  SliverPersistentHeader _buildHeader(
      BuildContext context, FilmProduction model) {
    return SliverPersistentHeader(
      pinned: false,
      delegate: FilmProductionSliverHeaderDelegate(
          child: Container(
            child: Hero(
              tag: model.filmProductionId,
              child: CachedNetworkImage(
                fit: BoxFit.contain,
                imageUrl: widget.filmProduction.poster,
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
          minHeight: 300.0,
          maxHeight: 600.0),
    );
  }

  Center _buildProgressIndicator() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Hero(
            child: CachedNetworkImage(
              fit: BoxFit.contain,
              imageUrl: widget.filmProduction.poster,
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            tag: widget.filmProduction.filmProductionId,
          ),
          Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
