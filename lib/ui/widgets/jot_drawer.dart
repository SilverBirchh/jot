import 'package:flutter/material.dart';

class JotDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Center(
                child: Text(
                  'Jot.',
                  style: TextStyle(color: Color(0xffF5C5BE), fontSize: 30),
                ),
              ),
              decoration: BoxDecoration(
                color: Color(0xff539D8B),
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/home');
              },
            ),
            ListTile(
              title: Text('Plans'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/plans');
              },
            ),
            ListTile(
              title: Text('Metrics'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/metrics');
              },
            ),
            ListTile(
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/profile');
              },
            ),
          ],
        ),
      ),
    );
  }
}
