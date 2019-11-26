import 'package:Jot/data/user/user_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ProfileEvent {}

class LogOut extends ProfileEvent {}

class SubmitFeedback extends ProfileEvent {
  SubmitFeedback(this.text, this.userId);
  final String text;
  final String userId;
}

class DeleteAccount extends ProfileEvent {
  DeleteAccount(this.userId);
  final String userId;
}


class UpdateUserProfile extends ProfileEvent {
  UpdateUserProfile(this.user);

  final User user;
}