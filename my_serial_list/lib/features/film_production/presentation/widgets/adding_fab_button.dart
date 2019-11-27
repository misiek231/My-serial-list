import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:my_serial_list/core/constants.dart';
import 'package:my_serial_list/features/film_production/domain/entities/film_production_rating.dart';
import 'package:my_serial_list/features/film_production/presentation/bloc/add_film_production.dart/bloc.dart';

import '../../../../injection_container.dart';

class AddingFabButton extends StatefulWidget {
  final bool visible;
  final FilmProductionRating filmProduction;
  final Function() refresh;
  final Function() navigateToTab;

  AddingFabButton({
    Key key,
    @required this.visible,
    @required this.filmProduction,
    @required this.refresh,
    @required this.navigateToTab,
  }) : super(key: key);

  @override
  _AddingFabButtonState createState() => _AddingFabButtonState();
}

class _AddingFabButtonState extends State<AddingFabButton> {
  final AddFilmProductionBloc bloc = sl();

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: bloc,
      listener: (context, state) {
        if (state is Added) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Pomyślnie dodano'),
            backgroundColor: Colors.greenAccent,
          ));
          widget.refresh();
        } else if (state is AddingError) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Wystąpił błąd'),
            backgroundColor: Colors.redAccent,
          ));
        }
      },
      child: BlocBuilder(
        bloc: bloc,
        builder: (context, state) {
          if (state is InitialAddFilmProductionState)
            return _buildFab();
          else if (state is Added)
            return _buildFab();
          else if (state is AddingError)
            return _buildFab();
          else if (state is Loading) return _buildFab(loading: true);
          return null;
        },
      ),
    );
  }

  Widget _buildFab({bool loading = false}) {
    return SpeedDial(
      visible: widget.visible,
      animatedIcon: loading ? null : AnimatedIcons.add_event,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: loading
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              )
            : SizedBox.shrink(),
      ),
      curve: Curves.bounceIn,
      overlayOpacity: 0.5,
      overlayColor: Colors.black,
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),
      children: [
        SpeedDialChild(
          child: Icon(Icons.brush),
          backgroundColor: Colors.blue,
          labelBackgroundColor: Theme.of(context).backgroundColor,
          label: 'Planowane',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => _addFilmProduction(context, WatchingStatus.plan),
        ),
        SpeedDialChild(
            child: Icon(Icons.accessibility),
            backgroundColor: Colors.red,
            labelBackgroundColor: Theme.of(context).backgroundColor,
            label: 'Zakończone',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => _addFilmProduction(context, WatchingStatus.finished)),
        SpeedDialChild(
          child: Icon(Icons.keyboard_voice),
          backgroundColor: Colors.green,
          labelBackgroundColor: Theme.of(context).backgroundColor,
          label: 'Aktualnie oglądane',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => _addFilmProduction(context, WatchingStatus.current),
        ),
      ],
    );
  }

  void _addFilmProduction(BuildContext context, WatchingStatus status) {
    if (widget.filmProduction.isSeries) {
      switch (status) {
        case WatchingStatus.plan:
          bloc.add(AddProduction(widget.filmProduction.filmProductionId, status,
              episodes: 0));
          break;
        case WatchingStatus.finished:
          bloc.add(AddProduction(widget.filmProduction.filmProductionId, status,
              episodes: widget.filmProduction.totalEpisodes));
          break;
        case WatchingStatus.current:
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Wybierz aktulnie oglądany odcinek'),
          ));
          widget.navigateToTab();
          break;
        default:
      }
    } else {
      bloc.add(AddProduction(widget.filmProduction.filmProductionId, status));
    }
  }
}
