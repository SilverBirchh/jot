import 'package:Jot/bloc/jot/bloc.dart';
import 'package:Jot/data/jot/jot_model.dart';
import 'package:Jot/data/time_period.dart';
import 'package:Jot/main_exports.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Create extends StatefulWidget {
  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  final GlobalKey<ScaffoldState> _createKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final TimePeriod timings = TimePeriod();
  Jot jot;

  @override
  void initState() {
    super.initState();
    jot = Jot(
        chosenPeriod: Period.TODAY,
        endDate: Timestamp.now(),
        startDate: Timestamp.now(),
        isImportant: false,
        ownerId: BlocProvider.of<ApplicationBloc>(context).state.user.uid,
        text: '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _createKey,
      appBar: AppBar(
        title: Text('Create'),
        centerTitle: true,
        backgroundColor: Color(0xff2ebf91),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save_alt),
            onPressed: () {
              if (_controller.text.isEmpty) {
                final SnackBar snackBar = SnackBar(
                  duration: Duration(seconds: 1),
                  content: const Text(
                      'Please jot down an accomplishment before saving'),
                );

                _createKey.currentState.showSnackBar(snackBar);
                _focusNode.requestFocus();
                return;
              }

              jot.text = _controller.text;
              BlocProvider.of<JotBloc>(context).add(
                AddJot(jot),
              );
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: <Color>[Color(0xff2ebf91), Color(0xff8360c3)],
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              stops: <double>[0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                'What have you accomplished recently that you\'re proud of?',
                style: TextStyle(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'When?',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        'Select a date or a time period',
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ],
                  ),
                  DropdownButton<Period>(
                    underline: Container(
                      height: 1.0,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.white38,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                    ),
                    value: jot.chosenPeriod,
                    selectedItemBuilder: (BuildContext context) {
                      return timings.timePeriods.map((Period value) {
                        return DropdownMenuItem<Period>(
                          value: value,
                          child: Text(
                            timings.typeToString(value),
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        );
                      }).toList();
                    },
                    items: timings.timePeriods.map((Period value) {
                      return DropdownMenuItem<Period>(
                        value: value,
                        child: Text(
                          timings.typeToString(value),
                          style: TextStyle(fontSize: 18),
                        ),
                      );
                    }).toList(),
                    onChanged: (Period val) => calculateJotPeriod(val),
                  ),
                ],
              ),
            ),
            if (jot.chosenPeriod == Period.DATE)
              Column(
                children: <Widget>[
                  Divider(
                    color: Colors.white38,
                    indent: 16,
                    endIndent: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Date?',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        GestureDetector(
                          onTap: () {
                            _focusNode.unfocus();
                            _selectDate(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Colors.white38),
                              ),
                            ),
                            child: Text(
                              _formatOtherTime(jot.startDate.toDate()),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            Divider(
              color: Colors.white38,
              indent: 16,
              endIndent: 16,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Significant?',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        'Is this a important achievement?',
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ],
                  ),
                  Checkbox(
                    checkColor: Colors.white,
                    activeColor: Colors.indigo,
                    value: jot.isImportant,
                    onChanged: (bool val) {
                      setState(() {
                        jot.isImportant = val;
                      });
                    },
                  )
                ],
              ),
            ),
            Divider(
              color: Colors.white38,
              indent: 16,
              endIndent: 16,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  focusNode: _focusNode,
                  style: TextStyle(
                      color: Colors.white, fontStyle: FontStyle.normal),
                  decoration: InputDecoration(
                    hintText: 'Add accomplishment...',
                    hintStyle: TextStyle(color: Colors.white, fontSize: 18),
                    border: InputBorder.none,
                  ),
                  cursorColor: Colors.white,
                  textCapitalization: TextCapitalization.sentences,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: _controller,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void calculateJotPeriod(Period period) {
    DateTime startDate = DateTime.now();
    DateTime endDate = DateTime.now();

    if (period == Period.YESTERDAY) {
      startDate = DateTime.now().subtract(
        Duration(days: 1),
      );
    } else if (period == Period.THIS_WEEK) {
      startDate = DateTime.now().subtract(
        Duration(days: 7),
      );
    } else if (period == Period.THIS_MONTH) {
      startDate = DateTime.now().subtract(
        Duration(days: 28),
      );
    } else if (period == Period.DATE) {
      startDate = DateTime.now();
    } else {
      startDate = DateTime.now();
    }

    setState(() {
      jot.chosenPeriod = period;
      jot.startDate = Timestamp.fromDate(startDate);
      jot.endDate = Timestamp.fromDate(endDate);
    });
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));

    setState(() {
      jot.startDate = Timestamp.fromDate(picked);
      jot.endDate = Timestamp.fromDate(picked);
    });
  }

  String _formatOtherTime(DateTime otherDate) {
    final DateFormat dateFormat = DateFormat('d/M/yy');
    return dateFormat.format(otherDate);
  }
}
