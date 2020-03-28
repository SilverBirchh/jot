import 'dart:async';
import 'package:Jot/api/plan.dart';
import 'package:Jot/data/plan/plan_model.dart';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class PlansBloc extends Bloc<PlansEvent, PlansState> {
  PlansBloc(this.plansApi);

  StreamSubscription<List<Plan>> _streamSubscription;

  final PlanApiBase plansApi;

  @override
  PlansState get initialState => InitialPlansState();

  @override
  Stream<PlansState> mapEventToState(
    PlansEvent event,
  ) async* {
    if (event is AddPlan) {
      yield* _addPlanToState(event);
    } else if (event is StreamPlans) {
      yield LoadingPlans();
      yield* _mapLoadAllPlansToState(event);
    } else if (event is PlanListUpdated) {
      yield* _mapPlansUpdateToState(event);
    } else if (event is DeletePlan) {
      yield* _mapDeletePlanToState(event);
    } else if (event is UpdatePlan) {
      yield* _updatePlanToState(event);
    }
  }

  Stream<PlansState> _mapPlansUpdateToState(PlanListUpdated event) async* {
    yield LoadedPlans(plans: event.plans);
  }

  Stream<PlansState> _mapLoadAllPlansToState(StreamPlans event) async* {
    try {
      _streamSubscription?.cancel();
      _streamSubscription = plansApi.plans(event.userId).listen(
        (List<Plan> jots) {
          add(
            PlanListUpdated(jots),
          );
        },
      );
    } catch (e) {
      yield ErrorPlans();
    }
  }

  Stream<PlansState> _addPlanToState(AddPlan event) async* {
    plansApi.addPlan(event.plan);
  }

  Stream<PlansState> _mapDeletePlanToState(DeletePlan event) async* {
    plansApi.deletePlan(event.planId);
  }

    Stream<PlansState> _updatePlanToState(UpdatePlan event) async* {
    plansApi.updatePlan(event.plan, event.uid);
  }
}
