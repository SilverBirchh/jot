import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Jot/api/profile.dart';
import './bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this.profileApiBase);

  final ProfileApiBase profileApiBase;

  @override
  ProfileState get initialState => InitialProfileState();

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is LogOut) {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      _auth.signOut();
    } else if (event is DeleteAccount) {
      profileApiBase.deleteUser(event.userId);
      final FirebaseAuth _auth = FirebaseAuth.instance;
      _auth.signOut();
    } else if (event is SubmitFeedback) {
      yield SendingFeedback();
      try {
        profileApiBase.submitFeedback(event.text, event.userId);
        yield SentFeedback();
      } catch (err) {
        yield FeedbackError();
      }
    } else if (event is UpdateUserProfile) {
      profileApiBase.updateUserTags(event.user);
    }
  }
}
