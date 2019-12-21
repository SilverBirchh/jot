import 'package:flutter/material.dart';

class AnonSignIn extends StatelessWidget {
  const AnonSignIn({
    Key key,
    this.onPressed,
  }) : super(key: key);

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190,
      child: MaterialButton(
        onPressed: () => this.onPressed(),
        color: Color(0xff25373D),
        splashColor: Colors.blue,
        highlightColor: Colors.blue,
        elevation: 0.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Sign in anonymously',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}