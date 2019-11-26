import 'package:Jot/bloc/filter/bloc.dart';
import 'package:Jot/main_exports.dart';
import 'package:flutter/material.dart';

class FilterModal extends StatefulWidget {
  @override
  _FilterModalState createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  bool onlySignificants = true;

  @override
  void initState() {
    super.initState();
    onlySignificants = BlocProvider.of<FilterBloc>(context).state.inportantOnly;
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Filter Jots'),
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Only significant entries',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            Checkbox(
              checkColor: Colors.white,
              activeColor: Colors.indigo,
              value: onlySignificants,
              onChanged: (bool val) {
                setState(() {
                  onlySignificants = val;
                });
              },
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FlatButton(
              shape: CircleBorder(),
              materialTapTargetSize: MaterialTapTargetSize.padded,
              child: Text('OK'),
              onPressed: () {
                BlocProvider.of<FilterBloc>(context).add(
                  UpdateFilters(inportantOnly: onlySignificants),
                );
                Navigator.pop(context);
              },
            )
          ],
        ),
      ],
    );
  }
}
