import 'package:cloud_firestore/cloud_firestore.dart';

import './jot_entity.dart';
import '../time_period.dart';

class Jot {
  Jot(
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

  Jot copyWith(
      {bool isImportant,
      String text,
      Timestamp startDate,
      Timestamp endDate,
      Period period,
      String ownerId}) {
    return Jot(
        isImportant: isImportant ?? this.isImportant,
        text: text ?? this.text,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        ownerId: ownerId ?? this.ownerId,
        chosenPeriod: chosenPeriod ?? this.chosenPeriod);
  }

  JotEntity toEntity() {
    return JotEntity(
        isImportant: isImportant,
        text: text,
        chosenPeriod: chosenPeriod,
        ownerId: ownerId,
        endDate: endDate,
        startDate: startDate);
  }

  static Jot fromEntity(JotEntity entity) {
    return Jot(
        isImportant: entity.isImportant,
        chosenPeriod: entity.chosenPeriod,
        endDate: entity.endDate,
        startDate: entity.startDate,
        ownerId: entity.ownerId,
        text: entity.text);
  }
}
