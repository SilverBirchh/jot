import 'package:Jot/bloc/application/application_bloc.dart';
import 'package:Jot/bloc/plans/bloc.dart';
import 'package:Jot/data/plan/plan_model.dart';
import 'package:Jot/data/step/step_model.dart' as Stepp;
import 'package:Jot/main_exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Jot/data/step/step_model.dart' as Stepp;

class CreatePlanPage extends StatefulWidget {
  CreatePlanPage({this.plan});

  final Plan plan;
  @override
  _CreatePlanPageState createState() => _CreatePlanPageState();
}

class _CreatePlanPageState extends State<CreatePlanPage> {
  final GlobalKey<ScaffoldState> _createPlanKey = GlobalKey<ScaffoldState>();

  final TextEditingController goalController = TextEditingController();

  List<TextEditingController> steps = [TextEditingController()];
  List<Stepp.Step> builtSteps;
  List<String> planTags = [];

  @override
  void initState() {
    super.initState();
    if (widget.plan != null) {
      goalController.text = widget.plan.goal;
      planTags = widget.plan.tags.map((e) => e.toString()).toList();
      steps = widget.plan.steps.map((Stepp.Step step) {
        return TextEditingController(text: step.text);
      }).toList();
      builtSteps = widget.plan.steps.map((Stepp.Step step) {
        return step;
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _createPlanKey,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          widget.plan != null ? 'Amend Plan' : 'Create Plan',
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
              if (goalController.text.isEmpty) {
                final SnackBar snackBar = SnackBar(
                  duration: Duration(seconds: 1),
                  content: const Text('Please add a goal before saving'),
                );

                _createPlanKey.currentState.showSnackBar(snackBar);
                return;
              }

              if (steps.isEmpty || steps.first.text.isEmpty) {
                final SnackBar snackBar = SnackBar(
                  duration: Duration(seconds: 1),
                  content: const Text('Please add a step before saving'),
                );

                _createPlanKey.currentState.showSnackBar(snackBar);
                return;
              }
              Plan plan = this.buildPlan();
              if (widget.plan != null) {
                BlocProvider.of<PlansBloc>(context)
                    .add(UpdatePlan(plan, widget.plan.uid));
              } else {
                BlocProvider.of<PlansBloc>(context).add(AddPlan(plan));
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color(0xff539D8B),
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                'What would you like to work towards?',
                style: TextStyle(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.center,
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
                controller: goalController,
                style:
                    TextStyle(color: Colors.white, fontStyle: FontStyle.normal),
                decoration: InputDecoration(
                  hintText: 'Add goal...',
                  hintStyle: TextStyle(color: Colors.white, fontSize: 18),
                  border: InputBorder.none,
                ),
                cursorColor: Colors.white,
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.multiline,
                maxLines: null,
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
                          (planTags == null
                              ? '0 tags'
                              : '${planTags.length} ${planTags.length == 1 ? 'tag' : 'tags'}'),
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
              child: Text(
                'What does it take to reach your goal?',
                style: TextStyle(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.center,
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
              child: Column(
                children: steps
                    .asMap()
                    .map(
                      (int index, TextEditingController controller) {
                        return MapEntry(
                          index,
                          Row(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width - 80,
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  onChanged: (value) {
                                    if (value.isEmpty) {
                                      setState(() {
                                        steps.removeAt(index);
                                        if (builtSteps != null &&
                                            builtSteps[index] != null) {
                                          builtSteps.removeAt(index);
                                        }
                                      });
                                    }
                                  },
                                  controller: controller,
                                  maxLines: null,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontStyle: FontStyle.normal),
                                  decoration: InputDecoration(
                                    hintText: 'Step...',
                                    hintStyle: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                    border: InputBorder.none,
                                  ),
                                  cursorColor: Colors.white,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.clear,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  setState(() {
                                    steps.removeAt(index);
                                    if (builtSteps != null &&
                                        builtSteps[index] != null) {
                                      builtSteps.removeAt(index);
                                    }
                                  });
                                },
                              )
                            ],
                          ),
                        );
                      },
                    )
                    .values
                    .toList(),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 16),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    steps.add(TextEditingController());
                    if (builtSteps != null) {
                      builtSteps.add(Stepp.Step());
                    }
                  });
                },
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 18,
                    ),
                    Text(
                      "Add Step",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Plan buildPlan() {
    List<Stepp.Step> stepsList = <Stepp.Step>[];
    steps.asMap().forEach((int index, TextEditingController value) {
      final bool completed = builtSteps != null && builtSteps[index] != null
          ? builtSteps[index].completed
          : false;
      stepsList.add(
        Stepp.Step(completed: completed, order: index, text: value.text),
      );
    });

    return Plan(
      goal: goalController.text,
      tags: planTags,
      steps: stepsList,
      startDate: widget.plan != null ? widget.plan.startDate : Timestamp.now(),
      ownerId: BlocProvider.of<ApplicationBloc>(context).state.user.uid,
    );
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
                                    planTags.add(tag);
                                  });
                                } else {
                                  final int index = planTags.indexOf(tag);
                                  setState(() {
                                    planTags.removeAt(index);
                                  });
                                }

                                setModalState(() {
                                  planTags = planTags;
                                });
                              },
                              value: planTags.contains(tag),
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
