import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:my_serial_list/features/film_production/domain/entities/film_production.dart';

class RatingCard extends StatelessWidget {
  final FilmProduction model;
  const RatingCard({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
          child: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          RatingBar(
            initialRating: model.rating,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 10,
            ignoreGestures: true,
            itemSize: 30,
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            onRatingUpdate: (_) {},
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Ocena: ${model.rating}',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Ilość głosów: ${model.votes}',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      )),
    );
  }
}
