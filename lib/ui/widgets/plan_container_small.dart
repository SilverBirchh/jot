import 'package:Jot/data/plan/plan_model.dart';
import 'package:flutter/material.dart';

class PlanContainerSmall extends StatefulWidget {
  PlanContainerSmall(this.plan);
  final Plan plan;

  @override
  _PlanContainerSmallState createState() => _PlanContainerSmallState();
}

class _PlanContainerSmallState extends State<PlanContainerSmall> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 150,
      child: Row(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width - 32,
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('${getStepsLeft(widget.plan)}'),
                    Row(
                      children: <Widget>[
                        if (widget.plan.tags != null &&
                            widget.plan.tags.isNotEmpty)
                          Container(
                            margin: EdgeInsets.only(left: 8),
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              widget.plan.tags.first,
                              textAlign: TextAlign.left,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 13),
                            ),
                          ),
                      ],
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width - 72,
                      height: 60,
                      child: RichText(
                        softWrap: true,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(text: '${widget.plan.goal}'),
                          ],
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_drop_down_circle,
                      color: Colors.blue,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  String getStepsLeft(Plan plan) {
    int completed = 0;
    for (var step in plan.steps) {
      if (step.completed != null && step.completed) {
        completed++;
      }
    }

    return '${completed.toString()} out ${plan.steps.length.toString()} steps completed';
  }
}
