import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Jot/data/feedback/feedback_model.dart';

abstract class ProfileApiBase {
  Future<void> submitFeedback(String text, String userId);

  Future<void> deleteUser(String userId);
}

class ProfileApi implements ProfileApiBase {
  final CollectionReference feedbackCollection =
      Firestore.instance.collection('feedback');

  final CollectionReference usersCollection =
      Firestore.instance.collection('users');

  @override
  Future<void> deleteUser(String userId) async {
    usersCollection.document(userId).delete();
  }

  @override
  Future<void> submitFeedback(String text, String userId) async {
    final Feedback feedback = Feedback(text: text, userId: userId);
    return feedbackCollection.add(feedback.toEntity().toDocument());
  }
}
