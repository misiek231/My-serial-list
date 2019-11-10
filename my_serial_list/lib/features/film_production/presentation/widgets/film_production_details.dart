import 'package:flutter/material.dart';
import 'package:my_serial_list/features/film_production/domain/entities/film_production.dart';
import 'package:meta/meta.dart';
import 'package:my_serial_list/features/film_production/presentation/widgets/comments_section.dart';
import 'package:my_serial_list/features/film_production/presentation/widgets/rating_card.dart';

import 'film_production_info.dart';

class FilmProductionDetails extends StatelessWidget {
  final FilmProduction model;
  const FilmProductionDetails({
    Key key,
    @required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        child: Column(
          children: <Widget>[
            FilmProductionInfo(model: model),
            RatingCard(model: model),
            CommentsSection(
              filmProductionId: model.filmProductionId,
            ),
          ],
        ),
      ),
    );
  }
}
