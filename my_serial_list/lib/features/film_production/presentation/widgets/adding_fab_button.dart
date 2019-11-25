import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class AddingFabButton extends StatelessWidget {
  final bool visible;
  const AddingFabButton({Key key, @required this.visible}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      visible: visible,
      animatedIcon: AnimatedIcons.add_event,
      curve: Curves.bounceIn,
      overlayOpacity: 0.5,
      overlayColor: Colors.black,
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),
      children: [
        SpeedDialChild(
            child: Icon(Icons.accessibility),
            backgroundColor: Colors.red,
            labelBackgroundColor: Theme.of(context).backgroundColor,
            label: 'Zakończone',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => print('FIRST CHILD')),
        SpeedDialChild(
          child: Icon(Icons.brush),
          backgroundColor: Colors.blue,
          labelBackgroundColor: Theme.of(context).backgroundColor,
          label: 'Planowane',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => print('SECOND CHILD'),
        ),
        SpeedDialChild(
          child: Icon(Icons.keyboard_voice),
          backgroundColor: Colors.green,
          labelBackgroundColor: Theme.of(context).backgroundColor,
          label: 'Aktualnie oglądane',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => print('THIRD CHILD'),
        ),
      ],
    );
  }
}
