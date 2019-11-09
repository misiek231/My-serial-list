import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_serial_list/core/constants.dart';
import 'package:my_serial_list/features/film_production/domain/entities/film_production.dart';
import 'package:my_serial_list/features/film_production/domain/entities/film_production_rating.dart';
import 'package:my_serial_list/features/film_production/presentation/bloc/film_production/bloc.dart';
import 'package:my_serial_list/features/film_production/presentation/utils/film_production_sliver_header_delegate.dart';
import 'package:my_serial_list/features/film_production/presentation/widgets/film_production_details.dart';
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
  String dropdownValue;

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    bloc.add(GetData(widget.filmProduction.filmProductionId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.filmProduction.title),
      ),
      body: BlocBuilder<FilmProductionBloc, FilmProductionState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is InitialFilmProductionState) {
            return _buildProgressIndicator();
          } else if (state is Loaded)
            return CustomScrollView(
              slivers: <Widget>[
                _buildHeader(context, state.filmProduction),
                FilmProductionDetails(model: state.filmProduction),
              ],
            );
          return null;
        },
      ),
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
}
