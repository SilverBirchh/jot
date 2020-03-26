import 'package:Jot/data/plan/plan_entity.dart';
import 'package:Jot/data/plan/plan_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class PlanApiBase {
  Future<void> addPlan(Plan plan);
  Stream<List<Plan>> plans(String ownerId);
}

class PlanApi implements PlanApiBase {
  final CollectionReference planCollection =
      Firestore.instance.collection('plan');

  @override
  Future<void> addPlan(Plan plan) {
    return planCollection.add(plan.toEntity().toDocument());
  }

  @override
  Stream<List<Plan>> plans(String ownerId) {
    try {
      return planCollection
          .where('ownerId', isEqualTo: ownerId)
          .orderBy('startDate', descending: true)
          .snapshots()
          .map((QuerySnapshot snapshot) {
        return snapshot.documents
            .map((DocumentSnapshot doc) =>
                Plan.fromEntity(PlanEntity.fromSnapshot(doc)))
            .toList();
      });
    } catch (e) {
      throw Exception();
    }
  }
}
