import 'package:Jot/ui/widgets/jot_drawer.dart';
import 'package:flutter/material.dart';

class PlansPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _metricsKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _metricsKey,
      drawer: JotDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: const Text(
          'Plans',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xffF5C5BE),
      ),
      body: Container(
        width: 0,
        height: 0,
      ),
    );
  }
}
