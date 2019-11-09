import 'package:meta/meta.dart';
import './user_entity.dart';

@immutable
class User {
  const User({@required this.uid, @required this.username, this.photoUrl})
      : assert(uid != null && username != null);

  final String uid;
  final String username;
  final String photoUrl;

  User copyWith({String uid, String username, String photoUrl}) {
    return User(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  @override
  int get hashCode =>
      uid.hashCode ^ username.hashCode ^ photoUrl.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          uid == other.uid &&
          username == other.username &&
          photoUrl == other.photoUrl;

  @override
  String toString() {
    return 'User { uid: $uid, username: $username, photoUrl: $photoUrl }';
  }

  UserEntity toEntity() {
    return UserEntity(uid, username, photoUrl);
  }

  static User fromEntity(UserEntity entity) {
    return User(
      uid: entity.uid,
      username: entity.username,
      photoUrl: entity.photoUrl,
    );
  }
}
