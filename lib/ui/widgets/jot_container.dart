import 'package:Jot/data/jot/jot_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class JotContainer extends StatefulWidget {
  JotContainer(this.jot, {this.isFirst, this.isLast});

  final Jot jot;
  final bool isFirst;
  final bool isLast;

  @override
  _JotContainerState createState() => _JotContainerState();
}

class _JotContainerState extends State<JotContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 150,
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 16),
            child: Column(
              children: <Widget>[
                Container(
                    width: 5,
                    height: 60,
                    color: widget.isFirst ? Colors.transparent : Colors.white),
                Container(
                  height: 30.0,
                  width: 12.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                Container(
                    width: 5,
                    height: 60,
                    color: widget.isLast ? Colors.transparent : Colors.white),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width - 66,
            padding: EdgeInsets.all(8),
            height: 150,
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: _calcDatePeriod(
                          widget.jot.startDate, widget.jot.endDate),
                    ),
                    if (widget.jot.isImportant)
                      Icon(
                        Icons.star,
                        color: Color(0xff2ebf91),
                      )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width - 82,
                      height: 60,
                      child: Text(
                        widget.jot.text,
                        softWrap: true,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),

                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _calcDatePeriod(Timestamp startDate, Timestamp endDate) {
    final DateFormat dateFormat = DateFormat('d/M/yy');
    final String startString = dateFormat.format(startDate.toDate());
    final String endString = dateFormat.format(endDate.toDate());
    return Text(
      '$startString${startString == endString ? '' : ' - $endString'}',
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}
