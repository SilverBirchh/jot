import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({@required this.showLoading});

  final bool showLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 200.0,
              width: 200.0,            
              child: const DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/icon/icon_invert.png'),
                  ),
                ),
              ),
            ),
            Container(
              child: showLoading ? const LinearProgressIndicator() : null,
              width: MediaQuery.of(context).size.width * 0.5,
            ),
          ],
        ),
      ),
    );
  }
}
