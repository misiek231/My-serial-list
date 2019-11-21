import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:my_serial_list/features/film_production/domain/entities/film_production.dart';
import 'package:meta/meta.dart';
import 'package:my_serial_list/features/film_production/presentation/widgets/comments_section.dart';
import 'package:my_serial_list/features/film_production/presentation/widgets/rating_card.dart';

import 'film_production_info.dart';

class FilmProductionDetails extends StatelessWidget {
  final FilmProduction model;
  const FilmProductionDetails({Key key, @required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        child: Column(
          children: <Widget>[
            FilmProductionInfo(model: model),
            RatingCard(model: model),
            model.isInMyList
                ? Card(
                    child: Column(
                      children: <Widget>[
                        Txt(
                          "Twoja ocena",
                          style: TxtStyle()
                            ..textColor(Colors.white)
                            ..alignment.center()
                            ..fontSize(20)
                            ..padding(all: 10),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: RatingBar(
                            initialRating: model.myRating.toDouble(),
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemCount: 10,
                            ignoreGestures: false,
                            itemSize: 30,
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            onRatingUpdate: (_) {},
                          ),
                        ),
                      ],
                    ),
                  )
                : Card(
                    child: Txt(
                      "Dodj film do swojej listy aby móc go ocenić",
                      style: TxtStyle()
                        ..alignment.center()
                        ..textColor(Colors.red)
                        ..fontSize(20)
                        ..padding(all: 20),
                    ),
                  ),
            CommentsSection(
              filmProductionId: model.filmProductionId,
              canAddComment: model.isInMyList,
            )
          ],
        ),
      ),
    );
  }
}
