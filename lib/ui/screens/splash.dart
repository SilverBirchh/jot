import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({this.showLoading = true});

  final bool showLoading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Color(0xff539D8B),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: null,
                margin: const EdgeInsets.only(top: 50.0),
                child: Text(
                  'Jot.',
                  style: TextStyle(
                      color: Color(0xffF5C5BE),
                      fontSize: 50,
                      decoration: null),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 50),),
              Container(
                child: showLoading ? const LinearProgressIndicator() : null,
                width: MediaQuery.of(context).size.width * 0.5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
