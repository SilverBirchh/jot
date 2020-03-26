import 'package:Jot/data/plan/plan_model.dart';
import 'package:flutter/material.dart';

class PlanContainer extends StatefulWidget {

  PlanContainer(this.plan);
  final Plan plan;

  @override
  _PlanContainerState createState() => _PlanContainerState();
}

class _PlanContainerState extends State<PlanContainer> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0,
      height: 0,
    );
  }
}