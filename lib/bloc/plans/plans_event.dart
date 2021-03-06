import 'package:Jot/data/plan/plan_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PlansEvent {}

class AddPlan extends PlansEvent {
  AddPlan(this.plan);

  final Plan plan;
}

class StreamPlans extends PlansEvent {
  StreamPlans(this.userId);

  final String userId;
}

class PlanListUpdated extends PlansEvent {
  PlanListUpdated(this.plans);
  final List<Plan> plans;
}

class DeletePlan extends PlansEvent {
  DeletePlan(this.planId);

  final String planId;
}

class UpdatePlan extends PlansEvent {
  UpdatePlan(this.plan, this.uid);

  final Plan plan;
  final String uid;
}

