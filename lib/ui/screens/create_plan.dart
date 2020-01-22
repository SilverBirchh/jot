import 'package:flutter/material.dart';

class CreatePlanPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _creaetPlanKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _creaetPlanKey,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: const Text(
          'Create Plan',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xffF5C5BE),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.save_alt,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color(0xff539D8B),
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                'What would you like to work towards?',
                style: TextStyle(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            Divider(
              indent: 16,
              endIndent: 16,
              color: Color(0xffF5C5BE),
            ),
            Container(
              padding: EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              child: TextField(
                style:
                    TextStyle(color: Colors.white, fontStyle: FontStyle.normal),
                decoration: InputDecoration(
                  hintText: 'Add goal...',
                  hintStyle: TextStyle(color: Colors.white, fontSize: 18),
                  border: InputBorder.none,
                ),
                cursorColor: Colors.white,
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
            ),
            Divider(
              indent: 16,
              endIndent: 16,
              color: Color(0xffF5C5BE),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                'What does it take to reach your goal?',
                style: TextStyle(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            Divider(
              indent: 16,
              endIndent: 16,
              color: Color(0xffF5C5BE),
            ),
            Container(
              padding: EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              child: TextField(
                style:
                    TextStyle(color: Colors.white, fontStyle: FontStyle.normal),
                decoration: InputDecoration(
                  hintText: 'Add step...',
                  hintStyle: TextStyle(color: Colors.white, fontSize: 18),
                  border: InputBorder.none,
                ),
                cursorColor: Colors.white,
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
