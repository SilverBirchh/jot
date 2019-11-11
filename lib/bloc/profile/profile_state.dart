import 'package:meta/meta.dart';

@immutable
abstract class ProfileState {}
  
class InitialProfileState extends ProfileState {}

class SendingFeedback extends ProfileState {}

class SentFeedback extends ProfileState {}

class FeedbackError extends ProfileState {}