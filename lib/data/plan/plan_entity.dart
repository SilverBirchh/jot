import 'package:Jot/data/step/step_entity.dart';
import 'package:Jot/data/step/step_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PlanEntity {
  PlanEntity({
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

  static PlanEntity fromSnapshot(DocumentSnapshot snap) {
    final List<Step> steps = (snap['steps'] as List).map((s) {
      return Step.fromEntity(StepEntity.fromSnapshot(s));
    }).toList();
    return PlanEntity(
      uid: snap.documentID,
      goal: snap['goal'],
      due: snap['due'],
      startDate: snap['startDate'],
      ownerId: snap['ownerId'],
      tags: snap['tags'],
      steps: steps,
    );
  }

  Map<String, Object> toDocument() {
    return <String, dynamic>{
      'goal': goal,
      'due': due,
      'startDate': startDate,
      'ownerId': ownerId,
      'tags': tags,
      'steps': steps.map((Step step) {
        return step.toEntity().toDocument();
      }).toList()
    };
  }
}
