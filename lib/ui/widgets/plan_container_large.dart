import 'package:Jot/bloc/plans/bloc.dart';
import 'package:Jot/data/plan/plan_model.dart';
import 'package:Jot/data/step/step_model.dart' as Stepp;
import 'package:Jot/main_exports.dart';
import 'package:flutter/material.dart';

class PlanContainerLarge extends StatelessWidget {
  const PlanContainerLarge(
    this.plan, {
    this.onTap,
  });

  final Plan plan;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.edit),
                color: Colors.blue[300],
                onPressed: () {
                  Navigator.pushNamed(context, '/create-plan', arguments: plan);
                  onTap();
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                color: Colors.red[300],
                onPressed: () {
                  BlocProvider.of<PlansBloc>(context).add(
                    DeletePlan(plan.uid),
                  );
                  onTap();
                },
              ),
            ],
          ),
          Divider(),
          if (plan.tags != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Wrap(
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                children: plan.tags.map(
                  (dynamic tag) {
                    return Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        tag,
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.black, fontSize: 13),
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
          Container(
            margin: EdgeInsets.only(top: 8, bottom: 8),
            child: Text('${getStepsLeft(plan)}'),
          ),
          GestureDetector(
            onTap: () => this.onTap(),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width - 82,
                  child: Text(
                    plan.goal,
                    maxLines: null,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                RotationTransition(
                  turns: new AlwaysStoppedAnimation(180 / 360),
                  child: Icon(
                    Icons.arrow_drop_down_circle,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.only(top: 4, bottom: 4),
          ),
          ...plan.steps.map((Stepp.Step step) => buildStep(step, context)).toList(),
        ],
      ),
    );
  }

  Widget buildStep(Stepp.Step step, BuildContext context) {
    final bool value = step.completed == null || !step.completed ? false : true;
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
            value: value,
            onChanged: (bool newValue) {
              step.completed = newValue;
              BlocProvider.of<PlansBloc>(context)
                  .add(UpdatePlan(plan, plan.uid));
            },
          ),
          Text(step.text)
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
