import 'package:meta/meta.dart';
import './feedback_entity.dart';

@immutable
class Feedback {
  const Feedback({this.text, this.userId});

  final String text;
  final String userId;

  Feedback copyWith({String text, String userId}) {
    return Feedback(
      text: text ?? this.text,
      userId: userId ?? this.userId,
    );
  }

  @override
  int get hashCode => text.hashCode ^ userId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Feedback &&
          runtimeType == other.runtimeType &&
          text == other.text &&
          userId == other.userId;

  @override
  String toString() {
    return 'User { text: $text }';
  }

  FeedbackEntity toEntity() {
    return FeedbackEntity(text, userId);
  }

  static Feedback fromEntity(Feedback entity) {
    return Feedback(text: entity.text, userId: entity.userId);
  }
}
