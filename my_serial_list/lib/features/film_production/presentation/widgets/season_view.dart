import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_serial_list/features/film_production/domain/entities/episode.dart';
import 'package:my_serial_list/features/film_production/presentation/bloc/episodes/bloc.dart';
import 'package:my_serial_list/features/film_production/presentation/widgets/error_view.dart';

import '../../../../injection_container.dart';

class SeasonView extends StatefulWidget {
  final season;
  final filmProductionId;
  final addCheckBoxes;
  final int watchedEpisodes;

  SeasonView({
    @required this.season,
    @required this.filmProductionId,
    this.addCheckBoxes = false,
    this.watchedEpisodes = 7,
    Key key,
  }) : super(key: key);

  @override
  _SeasonViewState createState() => _SeasonViewState();
}

class _SeasonViewState extends State<SeasonView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final EpisodeBloc bloc = sl<EpisodeBloc>();

  @override
  void initState() {
    bloc.add(GetData(
      filmProductionId: widget.filmProductionId,
      season: widget.season,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder(
      bloc: bloc,
      builder: (context, EpisodeState state) {
        if (state is Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is Loaded) {
          return ListView.builder(
            itemCount: state.episodes.length,
            itemBuilder: (context, index) {
              Episode model = state.episodes[index];
              return Card(
                child: CheckboxListTile(
                  onChanged: (a) {},
                  value: model.watched,
                  title: Text("${model.episodeNumber} - ${model.title}"),
                  subtitle: Text(model.released),
                ),
                color: model.watched
                    ? Colors.green.shade800
                    : Theme.of(context).backgroundColor,
              );
            },
          );
        } else if (state is Error) {
          return ErrorView(
            message: state.message,
            reload: () => bloc.add(
              GetData(
                filmProductionId: widget.filmProductionId,
                season: widget.season,
              ),
            ),
          );
        }
        return null;
      },
    );
  }
}
