import 'package:Jot/ui/widgets/filter_modal.dart';
import 'package:Jot/ui/widgets/jot_drawer.dart';
import 'package:Jot/ui/widgets/jot_list.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final GlobalKey<ScaffoldState> _homeKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _homeKey,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/create');
        },
      ),
      drawer: JotDrawer(),
      appBar: AppBar(
        title: Text(
          'Jot.',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Color(0xffF5C5BE),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.filter_list, color: Colors.black),
            onPressed: () => _showFilter(context),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color(0xff539D8B),
        child: JotList(),
      ),
    );
  }

  _showFilter(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return FilterModal();
      },
    );
  }
}
