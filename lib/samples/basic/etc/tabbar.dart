import 'package:flutter/material.dart';

class TabBarApp extends StatelessWidget {
  const TabBarApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => DefaultTabController(
    length: 3,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('Tabs Demo'),
        bottom: const TabBar(
          tabs: [
            Tab(icon: Icon(Icons.directions_car), text: 'car',),
            Tab(icon: Icon(Icons.directions_train), text: 'train',),
            Tab(icon: Icon(Icons.directions_bike), text: 'bike',),
          ],
        ),
      ),
      body: const TabBarView(
        children: [
          Icon(Icons.directions_car),
          Icon(Icons.directions_train),
          Icon(Icons.directions_bike),
        ]
      ),
    )
  );
}
