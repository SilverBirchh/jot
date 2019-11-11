import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackEntity {
  const FeedbackEntity(this.text, this.userId);

  final String text;
  final String userId;

  Map<String, Object> toJson() {
    return <String, dynamic>{
      'text': text,
      'userId': userId,
    };
  }

  @override
  String toString() {
    return 'Note { text: $text }';
  }

  static FeedbackEntity fromJson(Map<String, Object> json) {
    return FeedbackEntity(
      // ignore: avoid_as
      json['text'] as String,
      // ignore: avoid_as
      json['userId'] as String,
    );
  }

  static FeedbackEntity fromSnapshot(DocumentSnapshot snap) {
    return FeedbackEntity(
      snap['text'],
      snap['userId'],
    );
  }

  Map<String, Object> toDocument() {
    return <String, dynamic>{
      'text': text,
      'userId': userId,
    };
  }
}
