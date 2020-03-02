import 'package:cached_network_image/cached_network_image.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:my_serial_list/features/film_production/domain/entities/film_production_rating.dart';

import 'styles/list_element_style.dart';

class ListElement extends StatelessWidget {
  final FilmProductionRating model;

  const ListElement(this.model);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Hero(
              child: CachedNetworkImage(
                imageUrl: model.poster,
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              tag: model.filmProductionId,
            ),
          ),
          Expanded(
            child: buildText(context),
            flex: 5,
          ),
        ],
      ),
    );
  }

  Column buildText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Txt(
          this.model.title,
          style: titleTxtStyle.clone()
            ..textColor(Theme.of(context).accentColor),
        ),
        Txt(
          this.model.released,
          style: detailsTxtStyle,
        ),
        Txt(
          this.model.genre,
          style: detailsTxtStyle,
        ),
        Txt(
          this.model.plot,
          style: detailsTxtStyle,
        ),
      ],
    );
  }
}
