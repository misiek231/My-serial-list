import 'package:flutter/material.dart';
import 'package:my_serial_list/features/top_rated/presentation/widgets/app_drawer.dart';
import 'package:my_serial_list/features/top_rated/presentation/widgets/list_view.dart';

class TopRatedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My serial list'),
      ),
      backgroundColor: Colors.grey[600],
      body: InfiniteListView(),
      drawer: AppDrawer(),
    );
  }
}
