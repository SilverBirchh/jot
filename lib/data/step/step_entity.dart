import 'package:cloud_firestore/cloud_firestore.dart';

class StepEntity {
  StepEntity({this.order, this.text, this.completed});

  String text;
  int order;
  bool completed;

  static StepEntity fromSnapshot(snap) {
    return StepEntity(
      text: snap['text'],
      order: snap['order'],
      completed: snap['completed'],
    );
  }

  Map<String, Object> toDocument() {
    return <String, dynamic>{
      'order': order,
      'text': text,
      'completed': completed,
    };
  }
}
