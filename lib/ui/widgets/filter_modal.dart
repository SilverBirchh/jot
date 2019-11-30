import 'package:Jot/bloc/filter/bloc.dart';
import 'package:Jot/main_exports.dart';
import 'package:flutter/material.dart';

class FilterModal extends StatefulWidget {
  @override
  _FilterModalState createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  bool onlySignificants = true;
  List<String> tagsToApply = [];
  List<dynamic> listOfTags = [];

  @override
  void initState() {
    super.initState();
    listOfTags =
        BlocProvider.of<ApplicationBloc>(context).state.user.tags ?? <String>[];
    tagsToApply = BlocProvider.of<FilterBloc>(context).state.tagsToApply;
    onlySignificants = BlocProvider.of<FilterBloc>(context).state.inportantOnly;
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Filter Jots'),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              ),
            ],
          ),
        ),
        ...listOfTags.map((dynamic tag) {
          return Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      tag,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                Checkbox(
                  checkColor: Colors.white,
                  activeColor: Colors.indigo,
                  value: tagsToApply.contains(tag),
                  onChanged: (bool val) {
                    if (tagsToApply.contains(tag)) {
                      setState(() {
                        tagsToApply.remove(tag);
                      });
                    } else {
                      setState(() {
                        tagsToApply.add(tag);
                      });
                    }
                  },
                ),
              ],
            ),
          );
        }).toList(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FlatButton(
              shape: CircleBorder(),
              materialTapTargetSize: MaterialTapTargetSize.padded,
              child: Text('OK'),
              onPressed: () {
                BlocProvider.of<FilterBloc>(context).add(
                  UpdateFilters(
                      inportantOnly: onlySignificants,
                      tagsToApply: tagsToApply),
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
