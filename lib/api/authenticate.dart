import 'dart:async';
import 'package:Jot/data/user/user_entity.dart';
import 'package:Jot/data/user/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AuthenticationBase {
  Future<User> signIn();
  Future<User> isAuthenticated();
  Future<void> initialiseFirebaseUser(User user);
}

class Authentication implements AuthenticationBase {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference usersCollection =
      Firestore.instance.collection('users');

  @override
  Future<User> signIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;

    return User(
        uid: user.uid, username: user.displayName, photoUrl: user.photoUrl);
  }

  @override
  Future<User> isAuthenticated() async {
    final FirebaseUser currentUser = await _auth.currentUser();

    if (currentUser == null) {
      return null;
    }

    final DocumentSnapshot user =
        await usersCollection.document(currentUser.uid).get();

    return currentUser != null
        ? User.fromEntity(UserEntity.fromSnapshot(user))
        : null;
  }

  @override
  Future<void> initialiseFirebaseUser(User user) async {
    try {
      final DocumentSnapshot userDoc =
          await usersCollection.document(user.uid).get();

      if (userDoc == null || !userDoc.exists) {
        usersCollection
            .document(user.uid)
            .setData(user.toEntity().toDocument());
      }
    } catch (err) {
      throw Error();
    }
  }
}
