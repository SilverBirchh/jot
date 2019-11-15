import 'package:Jot/ui/widgets/filter_modal.dart';
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
      appBar: AppBar(
        title: Text('Jot.'),
        centerTitle: true,
        backgroundColor: Color(0xff2ebf91),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () => _showFilter(context),
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: <Color>[Color(0xff2ebf91), Color(0xff8360c3)],
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              stops: <double>[0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: JotList()
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
