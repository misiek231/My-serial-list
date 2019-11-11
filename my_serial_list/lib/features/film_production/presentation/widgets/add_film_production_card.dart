import 'package:flutter/material.dart';
import 'package:my_serial_list/features/film_production/domain/entities/film_production.dart';

class AddFilmProductionCard extends StatefulWidget {
  final FilmProduction model;
  const AddFilmProductionCard({Key key, @required this.model})
      : super(key: key);

  @override
  _AddFilmProductionCardState createState() => _AddFilmProductionCardState();
}

class _AddFilmProductionCardState extends State<AddFilmProductionCard> {
  String dropdownValue;

  _buildEpisodesCount() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: 'Ilość obejrzanych odcinków'),
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Text(
              'Dodaj ${widget.model.isSeries ? "serial" : "film"} do swojej listy',
              style: TextStyle(fontSize: 30),
            ),
            DropdownButton<String>(
              value: dropdownValue,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(
                color: Colors.deepPurple,
              ),
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue = newValue;
                });
              },
              items: <String>['Aktualnie oglądane', 'Zakończone', 'Planowane']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            widget.model.isSeries ? _buildEpisodesCount() : SizedBox.shrink(),
            RaisedButton(
              onPressed: () {},
              child: Text('Dodaj'),
            ),
            SizedBox(
              height: 10
            ),
          ],
        ),
      ),
    );
  }
}
