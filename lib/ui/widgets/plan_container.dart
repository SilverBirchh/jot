import 'package:Jot/data/plan/plan_model.dart';
import 'package:Jot/data/step/step_model.dart' as Stepp;
import 'package:Jot/ui/widgets/plan_container_large.dart';
import 'package:Jot/ui/widgets/plan_container_small.dart';
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
        child: PlanContainerSmall(
          widget.plan,
        ),
      ),
      secondChild: PlanContainerLarge(
        widget.plan,
                onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      ),
    );
  }
}