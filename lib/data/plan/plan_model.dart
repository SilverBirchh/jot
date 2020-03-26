import 'package:Jot/data/step/step_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './plan_entity.dart';

class Plan {
  Plan({
    this.uid,
    this.goal,
    this.due,
    this.startDate,
    this.ownerId,
    this.tags,
    this.steps,
  });

  String uid;
  String goal;
  Timestamp due;
  Timestamp startDate;
  String ownerId;
  List<dynamic> tags;
  List<Step> steps;

  Plan copyWith({
    String uid,
    String goal,
    Timestamp due,
    Timestamp startDate,
    String ownerId,
    List<dynamic> tags,
    List<Step> steps,
  }) {
    return Plan(
      uid: uid ?? this.uid,
      goal: goal ?? this.goal,
      due: due ?? this.due,
      startDate: startDate ?? this.startDate,
      ownerId: ownerId ?? ownerId,
      tags: tags ?? this.tags,
      steps: steps ?? this.steps,
    );
  }

  PlanEntity toEntity() {
    return PlanEntity(
      uid: uid,
      goal: goal,
      due: due,
      startDate: startDate,
      ownerId: ownerId,
      tags: tags,
      steps: steps,
    );
  }

  static Plan fromEntity(PlanEntity entity) {
    return Plan(
      uid: entity.uid,
      goal: entity.goal,
      due: entity.due,
      startDate: entity.startDate,
      ownerId: entity.ownerId,
      tags: entity.tags,
      steps: entity.steps,
    );
  }
}
