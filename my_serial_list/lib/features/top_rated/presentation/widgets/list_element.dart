import 'package:flutter/material.dart';
import 'package:my_serial_list/core/constants.dart';
import 'package:my_serial_list/features/top_rated/domain/entities/film_production_rating.dart';

class ListElement extends StatelessWidget {
  final FilmProductionRating model;

  const ListElement(this.model);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xff002132), borderRadius: new BorderRadius.circular(5)),
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.topLeft,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 150,
            child: Image.network(
              '$IMAGES_URL/${model.poster}',
            ),
          ),
          Flexible(child: buildText()),
        ],
      ),
      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
    );
  }

  Column buildText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(this.model.title,
              style: TextStyle(
                  color: Color(0xffce9f3d),
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(this.model.released,
              style: TextStyle(color: Colors.white, fontSize: 13)),
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
