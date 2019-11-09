import 'package:firebase_auth/firebase_auth.dart';

class UserEntity {
  const UserEntity(this.uid, this.username, this.photoUrl);

  final String uid;
  final String username;
  final String photoUrl;

  Map<String, Object> toJson() {
    return <String, dynamic>{
      'uid': uid,
      'username': username,
      'photoUrl': photoUrl,
    };
  }

  @override
  String toString() {
    return 'User { uid: $uid, username: $username, photoUrl: $photoUrl }';
  }

  static UserEntity fromJson(Map<String, Object> json) {
    return UserEntity(
      // ignore: avoid_as
      json['uid'] as String,
      // ignore: avoid_as
      json['username'] as String,
      // ignore: avoid_as
      json['photoUrl'] as String,
    );
  }

  static UserEntity fromSnapshot(FirebaseUser snap) {
    return UserEntity(snap.uid, snap.displayName, snap.photoUrl);
  }

  Map<String, Object> toDocument() {
    return <String, dynamic>{
      'uid': uid,
      'username': username,
      'photoUrl': photoUrl,
    };
  }
}
