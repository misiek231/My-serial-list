import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_serial_list/features/film_production/domain/entities/film_production_rating.dart';

class ListElement extends StatelessWidget {
  final FilmProductionRating model;

  const ListElement(this.model);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 150,
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
          Flexible(child: buildText(context)),
        ],
      ),
    );
  }

  Column buildText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(this.model.title,
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(this.model.released, style: TextStyle(fontSize: 13)),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(this.model.genre,
              style: TextStyle(color: Colors.white, fontSize: 13)),
        ),
        Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(this.model.plot,
                style: TextStyle(color: Colors.white, fontSize: 15))),
      ],
    );
  }
}
