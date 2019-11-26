import 'package:cloud_firestore/cloud_firestore.dart';
import '../time_period.dart';

class JotEntity {
  JotEntity(
      {this.uid,
      this.isImportant,
      this.text,
      this.chosenPeriod,
      this.endDate,
      this.startDate,
      this.ownerId,
      this.tags});

  bool isImportant;
  String text;
  Timestamp startDate;
  Timestamp endDate;
  Period chosenPeriod;
  String ownerId;
  String uid;
  List<dynamic> tags;

  final TimePeriod timings = TimePeriod();

  static JotEntity fromSnapshot(DocumentSnapshot snap) {
    final TimePeriod timings = TimePeriod();

    return JotEntity(
      uid: snap.documentID,
      isImportant: snap['isImportant'],
      text: snap['text'],
      chosenPeriod: timings.stringToType(snap['chosenPeriod']),
      endDate: snap['endDate'],
      startDate: snap['startDate'],
      ownerId: snap['ownerId'],
      tags: snap['tags'],
    );
  }

  Map<String, Object> toDocument() {
    return <String, dynamic>{
      'isImportant': isImportant,
      'text': text,
      'chosenPeriod': timings.typeToString(chosenPeriod),
      'endDate': endDate,
      'startDate': startDate,
      'ownerId': ownerId,
      'tags': tags,
    };
  }
}
