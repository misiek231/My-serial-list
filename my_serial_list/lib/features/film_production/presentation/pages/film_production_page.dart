import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_serial_list/core/constants.dart';
import 'package:my_serial_list/features/film_production/domain/entities/film_production.dart';
import 'package:my_serial_list/features/film_production/presentation/bloc/film_production/bloc.dart';
import '../../../../injection_container.dart';
import 'package:meta/meta.dart';

class FilmProductionPage extends StatefulWidget {
  final int filmProductionId;
  FilmProductionPage({Key key, @required this.filmProductionId})
      : super(key: key);

  @override
  _FilmProductionPageState createState() => _FilmProductionPageState();
}

class _FilmProductionPageState extends State<FilmProductionPage> {
  FilmProductionBloc bloc = sl<FilmProductionBloc>();

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    bloc.add(GetData(widget.filmProductionId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My serial list'),
      ),
      backgroundColor: Colors.grey[600],
      body: BlocBuilder<FilmProductionBloc, FilmProductionState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is Loaded) return _buildBody(state.filmProduction);
        },
      ),
    );
  }

  Widget _buildBody(FilmProduction filmProduction) {
    return Center(
      child: Column(
        children: <Widget>[
          Image.network('$IMAGES_URL/${filmProduction.poster}'),
          Text(
            filmProduction.title,
            style: TextStyle(fontSize: 50, color: Colors.white),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                'Gatunek: ${filmProduction.genre}',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              Text(
                'Data wydania: ${filmProduction.released}',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ],
          ),
          Text(
            'Aktorzy: ${filmProduction.actors}',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          Text(
            'Reżyser: ${filmProduction.director}',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          SizedBox(height: 20),
          Text(
            filmProduction.plot,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.white),
          )
        ],
      ),
    );
  }
}
