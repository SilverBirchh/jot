import 'package:Jot/data/plan/plan_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PlansState {}

class InitialPlansState extends PlansState {}

class LoadingPlans extends PlansState {}

class ErrorPlans extends PlansState {}

class LoadedPlans extends PlansState {
  LoadedPlans({this.plans});
  final List<Plan> plans;

  LoadedPlans copyWith({
    List<Plan> plans,
  }) {
    return LoadedPlans(
      plans: plans ?? this.plans,
    );
  }
}
