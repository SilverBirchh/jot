import 'package:Jot/bloc/jot/bloc.dart';
import 'package:Jot/data/jot/jot_model.dart';
import 'package:Jot/data/time_period.dart';
import 'package:Jot/main_exports.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// TODO Refactor this and break it up 
class Create extends StatefulWidget {
  Create({this.jot});

  final Jot jot;
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
    if (widget.jot != null) {
      _controller.text = widget.jot.text;
    }

    jot = widget.jot != null
        ? Jot(
            chosenPeriod: widget.jot.chosenPeriod,
            endDate: widget.jot.endDate,
            startDate: widget.jot.startDate,
            isImportant: widget.jot.isImportant,
            tags: List.from(widget.jot.tags),
            ownerId: BlocProvider.of<ApplicationBloc>(context).state.user.uid,
            text: widget.jot.text)
        : Jot(
            chosenPeriod: Period.TODAY,
            endDate: Timestamp.now(),
            startDate: Timestamp.now(),
            isImportant: false,
            tags: [],
            ownerId: BlocProvider.of<ApplicationBloc>(context).state.user.uid,
            text: '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _createKey,
      appBar: AppBar(
        title: widget.jot == null
            ? Text(
                'Create',
                style: TextStyle(
                  color: Colors.black,
                ),
              )
            : Text(
                'Amend',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
        centerTitle: true,
        backgroundColor: Color(0xffF5C5BE),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.save_alt,
              color: Colors.black,
            ),
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

              if (widget.jot == null) {
                BlocProvider.of<JotBloc>(context).add(
                  AddJot(jot),
                );
              } else {
                BlocProvider.of<JotBloc>(context).add(
                  UpdateJot(jot, widget.jot.uid),
                );
              }
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Container(
        color: Color(0xff539D8B),
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: <Widget>[
            if (widget.jot == null)
              Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  'What have you accomplished recently that you\'re proud of?',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
            if (widget.jot == null)
              Divider(
                indent: 16,
                endIndent: 16,
                color: Color(0xffF5C5BE),
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
                        widget.jot == null ? 'When?' : 'Period:',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      if (widget.jot == null)
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
                  )
                ],
              ),
            ),
            if (jot.chosenPeriod == Period.DATE && widget.jot != null)
              Column(
                children: <Widget>[
                  Divider(
                    indent: 16,
                    endIndent: 16,
                    color: Color(0xffF5C5BE),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Date:',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Colors.white38),
                              ),
                            ),
                            child: GestureDetector(
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
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            if (jot.chosenPeriod == Period.DATE && widget.jot == null)
              Column(
                children: <Widget>[
                  Divider(
                    indent: 16,
                    endIndent: 16,
                    color: Color(0xffF5C5BE),
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
              indent: 16,
              endIndent: 16,
              color: Color(0xffF5C5BE),
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
                        widget.jot == null ? 'Significant?' : 'Significant:',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      if (widget.jot == null)
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
              indent: 16,
              endIndent: 16,
              color: Color(0xffF5C5BE),
            ),
            GestureDetector(
              onTap: () => {_showTagsModal()},
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Tags',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        Text(
                          (jot?.tags == null
                              ? '0 tags'
                              : '${jot.tags.length} ${jot.tags.length == 1 ? 'tag' : 'tags'}'),
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              indent: 16,
              endIndent: 16,
              color: Color(0xffF5C5BE),
            ),
            Container(
              padding: EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              child: TextField(
                focusNode: _focusNode,
                style:
                    TextStyle(color: Colors.white, fontStyle: FontStyle.normal),
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

  void _showTagsModal() async {
    List<String> tags =
        BlocProvider.of<ApplicationBloc>(context).state.user.tags;
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return tags == null || tags.isEmpty
            ? Container(
                child: Wrap(
                  children: <Widget>[
                    ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, '/tags');
                      },
                      leading: Icon(Icons.edit),
                      title: const Text('You have no tags. Tap to add tags.'),
                    ),
                  ],
                ),
              )
            : Container(
                child: Wrap(
                  children: tags.map(
                    (String tag) {
                      return StatefulBuilder(
                        builder:
                            (BuildContext context, StateSetter setModalState) {
                          return ListTile(
                            onTap: () {},
                            leading: Checkbox(
                              onChanged: (bool val) {
                                if (val) {
                                  setState(() {
                                    jot.tags.add(tag);
                                  });
                                } else {
                                  final int index = jot.tags.indexOf(tag);
                                  setState(() {
                                    jot.tags.removeAt(index);
                                  });
                                }

                                setModalState(() {
                                  jot = jot;
                                });
                              },
                              value: jot.tags.contains(tag),
                            ),
                            title: Text(tag),
                          );
                        },
                      );
                    },
                  ).toList(),
                ),
              );
      },
    );
  }
}
