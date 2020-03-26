import 'package:Jot/ui/widgets/jot_drawer.dart';
import 'package:Jot/ui/widgets/plan_list.dart';
import 'package:flutter/material.dart';

class PlansPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _planKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _planKey,
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/create-plan');
        },
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color(0xff539D8B),
        child: PlanList(),
      ),
    );
  }
}
