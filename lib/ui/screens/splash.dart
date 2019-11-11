import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({this.showLoading = true});

  final bool showLoading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: <Color>[Color(0xff2ebf91), Color(0xff8360c3)],
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              stops: <double>[0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
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
                      color: Colors.white,
                      fontSize: 70,
                      fontWeight: FontWeight.bold,
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
