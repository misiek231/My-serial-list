import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:my_serial_list/core/constants.dart';
import 'package:my_serial_list/features/film_production/domain/entities/film_production.dart';
import 'package:my_serial_list/features/film_production/domain/entities/film_production_rating.dart';
import 'package:my_serial_list/features/film_production/presentation/bloc/film_production/bloc.dart';
import 'package:my_serial_list/features/film_production/presentation/utils/film_production_sliver_header_delegate.dart';
import 'package:my_serial_list/features/film_production/presentation/widgets/adding_fab_button.dart';
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

class _FilmProductionPageState extends State<FilmProductionPage> {
  FilmProductionBloc bloc = sl<FilmProductionBloc>();
  List<Widget> seasonViews;

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    bloc.add(GetData(widget.filmProduction.filmProductionId));

    if (widget.filmProduction.isSeries) {
      seasonViews = List.generate(
        widget.filmProduction.seasons,
        (index) => SeasonView(season: index + 1),
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
      floatingActionButton: AddingFabButton(),
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
            return _buildError(state);
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
    return TabBarView(children: a);
  }

  TabBar _buildTabBar() {
    return TabBar(
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
              child: Image.network(
                '$IMAGES_URL/${widget.filmProduction.poster}',
                fit: BoxFit.contain,
              ),
            ),
          ),
          minHeight: 300.0,
          maxHeight: 600.0),
    );
  }

  Column _buildError(Error state) {
    return Column(
      children: <Widget>[
        Center(
          child: Text(
            state.error,
            style: TextStyle(fontSize: 30),
          ),
        ),
        SizedBox(height: 20),
        RaisedButton(
          child: Text('Odśwież'),
          onPressed: () =>
              bloc.add(GetData(widget.filmProduction.filmProductionId)),
        )
      ],
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
            child: Image.network(
              '$IMAGES_URL/${widget.filmProduction.poster}',
              fit: BoxFit.fitWidth,
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
