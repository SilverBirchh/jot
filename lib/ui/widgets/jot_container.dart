import 'package:Jot/data/jot/jot_model.dart';
import 'package:Jot/ui/widgets/jot_container_large.dart';
import 'package:Jot/ui/widgets/jot_container_small.dart';
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
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 200),
      crossFadeState:
          isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      firstChild: GestureDetector(
        onTap: () {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
        child: JotContainerSmall(
          widget.jot,
          isFirst: widget.isFirst,
          isLast: widget.isLast,
          datePeriod: _calcDatePeriod(widget.jot.startDate, widget.jot.endDate),
        ),
      ),
      secondChild: JotContainerLarge(
        widget.jot,
        isFirst: widget.isFirst,
        isLast: widget.isLast,
        datePeriod: _calcDatePeriod(widget.jot.startDate, widget.jot.endDate),
                onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
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
