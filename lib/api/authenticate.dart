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
    return currentUser != null
        ? User.fromEntity(UserEntity.fromSnapshot(currentUser))
        : null;
  }

  @override
  Future<void> initialiseFirebaseUser(User user) async {
    try {
      final QuerySnapshot result = await usersCollection
          .where('uid', isEqualTo: user.uid)
          .getDocuments();

      final List<DocumentSnapshot> documents = result.documents;

      if (documents.isEmpty) {
        usersCollection
            .document(user.uid)
            .setData(user.toEntity().toDocument());
      }
    } catch (err) {
      throw Error();
    }
  }
}