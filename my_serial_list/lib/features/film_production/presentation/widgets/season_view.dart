import 'package:flutter/material.dart';

class SeasonView extends StatelessWidget {
  final season;
  const SeasonView({
    @required this.season,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Season $season'));
  }
}
