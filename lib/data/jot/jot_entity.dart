import 'package:cloud_firestore/cloud_firestore.dart';
import '../time_period.dart';

class JotEntity {
  JotEntity(
      {this.isImportant,
      this.text,
      this.chosenPeriod,
      this.endDate,
      this.startDate,
      this.ownerId});

  bool isImportant;
  String text;
  Timestamp startDate;
  Timestamp endDate;
  Period chosenPeriod;
  String ownerId;

  final TimePeriod timings = TimePeriod();

  static JotEntity fromSnapshot(DocumentSnapshot snap) {
    final TimePeriod timings = TimePeriod();
    
    return JotEntity(
      isImportant: snap['isImportant'],
      text: snap['text'],
      chosenPeriod: timings.stringToType(snap['chosenPeriod']),
      endDate: snap['endDate'],
      startDate: snap['startDate'],
      ownerId: snap['ownerId'],
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
    };
  }
}
