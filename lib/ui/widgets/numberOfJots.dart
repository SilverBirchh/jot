import 'package:Jot/bloc/jot/bloc.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class NumberOfJots extends StatefulWidget {
  NumberOfJots({this.jotState});

  final LoadedJots jotState;

  @override
  State<StatefulWidget> createState() => NumberOfJotsState();
}

class NumberOfJotsState extends State<NumberOfJots> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.8,
      child: Card(
        color: const Color(0xff2c4260),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(34.0, 8.0, 8.0, 8.0),
              child: AutoSizeText(
                "Total Jots",
                maxLines: 1,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  widget.jotState.jots.length.toString(),
                  style: TextStyle(fontSize: 150, color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
