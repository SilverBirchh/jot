import 'package:Jot/bloc/application/bloc.dart';
import 'package:Jot/bloc/filter/bloc.dart';
import 'package:Jot/bloc/jot/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class FilterModal extends StatefulWidget {
  FilterModal();

  @override
  _FilterModalState createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  bool onlySignificants = true;
  List<String> tagsToApply = [];
  List<dynamic> listOfTags = [];
  DateTime from;
  DateTime to;

  void _setFilters() {
    BlocProvider.of<FilterBloc>(context).add(
      UpdateFilters(
          inportantOnly: onlySignificants,
          tagsToApply: tagsToApply,
          toDate: to,
          fromDate: from),
    );

    final String userId =
        BlocProvider.of<ApplicationBloc>(context).state.user.uid;
    BlocProvider.of<JotBloc>(context).add(
      StreamJotsByDate(userId, fromDate: from, toDate: to),
    );
    Navigator.pop(context);
  }

  Future<Null> _selectDate(BuildContext context, bool isFromDate) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1980),
        lastDate: DateTime.now());

    setState(() {
      isFromDate ? from = picked : to = picked;
    });
  }

  String _formatDate(DateTime otherDate) {
    final DateFormat dateFormat = DateFormat('d/M/yy');
    return dateFormat.format(otherDate);
  }

  @override
  void initState() {
    super.initState();
    listOfTags =
        BlocProvider.of<ApplicationBloc>(context).state.user.tags ?? <String>[];
    tagsToApply = BlocProvider.of<FilterBloc>(context).state.tagsToApply;
    onlySignificants = BlocProvider.of<FilterBloc>(context).state.inportantOnly;
    to = BlocProvider.of<FilterBloc>(context).state.toDate;
    from = BlocProvider.of<FilterBloc>(context).state.fromDate;
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(
        'Filter Jots',
        textAlign: TextAlign.center,
      ),
      titlePadding: EdgeInsets.only(top: 16),
      children: <Widget>[
        Divider(
          indent: 16,
          endIndent: 16,
          color: Color(0xffF5C5BE),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Significant entries',
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
        Divider(
          indent: 16,
          endIndent: 16,
          color: Color(0xffF5C5BE),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: Text(
            'Date Period',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'From',
                style: TextStyle(fontSize: 18),
              ),
              GestureDetector(
                onTap: () => _selectDate(context, true),
                child: Text(
                  from == null ? 'All time' : _formatDate(from),
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16, top: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'To',
                style: TextStyle(fontSize: 18),
              ),
              GestureDetector(
                onTap: () => _selectDate(context, false),
                child: Text(
                  to == null ? 'Today' : _formatDate(to),
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
        Divider(
          indent: 16,
          endIndent: 16,
          color: Color(0xffF5C5BE),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Text(
            'Tags',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
        Divider(
          indent: 16,
          endIndent: 16,
          color: Color(0xffF5C5BE),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            FlatButton(
              shape: CircleBorder(),
              materialTapTargetSize: MaterialTapTargetSize.padded,
              child: Text('Clear'),
              onPressed: () {
                BlocProvider.of<FilterBloc>(context).add(
                  UpdateFilters(inportantOnly: false, tagsToApply: <String>[]),
                );
                final String userId =
                    BlocProvider.of<ApplicationBloc>(context).state.user.uid;
                BlocProvider.of<JotBloc>(context).add(
                  StreamJots(userId),
                );
                Navigator.pop(context);
              },
            ),
            FlatButton(
              shape: CircleBorder(),
              materialTapTargetSize: MaterialTapTargetSize.padded,
              child: Text('OK'),
              onPressed: () => _setFilters(),
            )
          ],
        ),
      ],
    );
  }
}
