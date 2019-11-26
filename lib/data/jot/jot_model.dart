import 'package:cloud_firestore/cloud_firestore.dart';

import './jot_entity.dart';
import '../time_period.dart';

class Jot {
  Jot(
      {this.uid,
      this.isImportant,
      this.text,
      this.chosenPeriod,
      this.endDate,
      this.startDate,
      this.ownerId,
      this.tags});

  String uid;
  bool isImportant;
  String text;
  Timestamp startDate;
  Timestamp endDate;
  Period chosenPeriod;
  String ownerId;
  List<dynamic> tags;

  Jot copyWith(
      {String uid,
      bool isImportant,
      String text,
      Timestamp startDate,
      Timestamp endDate,
      Period period,
      String ownerId,
      List<dynamic> tags}) {
    return Jot(
        uid: uid ?? this.uid,
        isImportant: isImportant ?? this.isImportant,
        text: text ?? this.text,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        ownerId: ownerId ?? this.ownerId,
        chosenPeriod: chosenPeriod ?? this.chosenPeriod,
        tags: tags ?? this.tags);
  }

  JotEntity toEntity() {
    return JotEntity(
        uid: uid,
        isImportant: isImportant,
        text: text,
        chosenPeriod: chosenPeriod,
        ownerId: ownerId,
        endDate: endDate,
        startDate: startDate,
        tags: tags);
  }

  static Jot fromEntity(JotEntity entity) {
    return Jot(
      uid: entity.uid,
      isImportant: entity.isImportant,
      chosenPeriod: entity.chosenPeriod,
      endDate: entity.endDate,
      startDate: entity.startDate,
      ownerId: entity.ownerId,
      text: entity.text,
      tags: entity.tags,
    );
  }
}
