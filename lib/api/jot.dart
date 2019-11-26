import 'package:Jot/data/jot/jot_entity.dart';
import 'package:Jot/data/jot/jot_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class JotApiBase {
  Future<void> addJot(Jot jot);
  Future<void> deleteJot(String jotId);
  Future<void> updateJot(Jot jot);
  Stream<List<Jot>> jots(String ownerId);
}

class JotApi implements JotApiBase {
  final CollectionReference jotCollection =
      Firestore.instance.collection('jot');

  @override
  Future<void> addJot(Jot jot) {
    return jotCollection.add(jot.toEntity().toDocument());
  }

  @override
  Future<void> deleteJot(String jotId) async {
    return jotCollection.document(jotId).delete();
  }

  @override
  Stream<List<Jot>> jots(String ownerId) {
    try {
      return jotCollection
          .where('ownerId', isEqualTo: ownerId)
          .orderBy('endDate', descending: true)
          .snapshots()
          .map((QuerySnapshot snapshot) {
        return snapshot.documents
            .map((DocumentSnapshot doc) =>
                Jot.fromEntity(JotEntity.fromSnapshot(doc)))
            .toList();
      });
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<void> updateJot(Jot jot) async {
    jotCollection.document(jot.uid).updateData(jot.toEntity().toDocument());
  }
}
