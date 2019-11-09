import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:my_serial_list/features/film_production/domain/entities/film_production.dart';

class FilmProductionInfo extends StatelessWidget {
  const FilmProductionInfo({
    Key key,
    @required this.model,
  }) : super(key: key);

  final FilmProduction model;

  @override
  Widget build(BuildContext context) {
    var myGroup = AutoSizeGroup();
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Column(
            children: <Widget>[
              AutoSizeText(
                'Gatunek: ${model.genre}',
                style: TextStyle(fontSize: 20, color: Colors.white),
                minFontSize: 10,
                group: myGroup,
              ),
              AutoSizeText(
                'Data wydania: ${model.released}',
                style: TextStyle(fontSize: 20, color: Colors.white),
                group: myGroup,
              ),
              AutoSizeText(
                'Aktorzy: ${model.actors}',
                style: TextStyle(fontSize: 20, color: Colors.white),
                textAlign: TextAlign.center,
                maxLines: 1,
                group: myGroup,
              ),
              AutoSizeText(
                'Reżyser: ${model.director}',
                style: TextStyle(fontSize: 20, color: Colors.white),
                group: myGroup,
              ),
              SizedBox(height: 20),
              AutoSizeText(
                model.plot,
                textAlign: TextAlign.center,
                group: myGroup,
                style: TextStyle(fontSize: 20, color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
