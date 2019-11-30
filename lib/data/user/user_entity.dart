import 'package:cloud_firestore/cloud_firestore.dart';

class UserEntity {
  const UserEntity(this.uid, this.username, this.photoUrl, this.tags);

  final String uid;
  final String username;
  final String photoUrl;
  final List<String> tags;

  Map<String, Object> toJson() {
    return <String, dynamic>{
      'uid': uid,
      'username': username,
      'photoUrl': photoUrl,
      'tags': tags,
    };
  }

  static UserEntity fromJson(Map<String, Object> json) {
    return UserEntity(
      // ignore: avoid_as
      json['uid'] as String,
      // ignore: avoid_as
      json['username'] as String,
      // ignore: avoid_as
      json['photoUrl'] as String,
      // ignore: avoid_as
      json['tags'] as List<String>,
    );
  }

  static UserEntity fromSnapshot(DocumentSnapshot snap) {
    return UserEntity(
      snap.documentID,
      snap.data['username'],
      snap.data['photoUrl'],
      snap.data['tags'] == null
          ? <String>[]
          : List<String>.from(snap.data['tags'].cast<String>()),
    );
  }

  Map<String, Object> toDocument() {
    return <String, dynamic>{
      'uid': uid,
      'username': username,
      'photoUrl': photoUrl,
      'tags': tags,
    };
  }
}
