import 'package:flutter/material.dart';

class ButtonIndicator extends StatelessWidget {
  final Function onPressed;
  final bool isBusy;
  final String text;

  const ButtonIndicator({Key key, this.onPressed, this.isBusy, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: const EdgeInsets.all(15.0),
      onPressed: onPressed,
      child: isBusy
          ? SizedBox(
              child: CircularProgressIndicator(
                strokeWidth: 3,
              ),
              height: 20.0,
              width: 20.0,
            )
          : Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
    );
  }
}
