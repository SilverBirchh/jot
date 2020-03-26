import 'package:Jot/bloc/application/bloc.dart';
import 'package:Jot/bloc/plans/bloc.dart';
import 'package:Jot/ui/widgets/plan_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanList extends StatefulWidget {
  @override
  _PlanListState createState() => _PlanListState();
}

class _PlanListState extends State<PlanList> {
  PlansBloc plansBloc;

  @override
  void initState() {
    super.initState();
    plansBloc = BlocProvider.of<PlansBloc>(context);
    final String userId =
        BlocProvider.of<ApplicationBloc>(context).state.user.uid;
    plansBloc.add(
      StreamPlans(userId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlansBloc, PlansState>(
      builder: (BuildContext context, PlansState jotState) {
        if (jotState is LoadingPlans) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (jotState is ErrorPlans) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(
                  'Could not load Jots.\nPlease try again.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                splashColor: Colors.grey,
                icon: Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
                onPressed: () {
                  final String userId =
                      BlocProvider.of<ApplicationBloc>(context).state.user.uid;
                  plansBloc.add(
                    StreamPlans(userId),
                  );
                },
              )
            ],
          );
        }

        if (jotState is LoadedPlans) {
          if (jotState.plans.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'Sorry, you currently have no plans. Create one and it will appear here...',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            );
          }

          return ListView.builder(
            itemCount: jotState.plans.length,
            itemBuilder: (BuildContext context, int index) {
              return PlanContainer(
                jotState.plans[index],
              );
            },
          );
        }

        return Container(
          width: 0,
          height: 0,
        );
      },
    );
  }
}
