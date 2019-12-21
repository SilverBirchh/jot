import 'package:meta/meta.dart';
import './user_entity.dart';

@immutable
class User {
  const User(
      {@required this.uid, @required this.username, this.photoUrl, this.tags})
      : assert(uid != null);

  final String uid;
  final String username;
  final String photoUrl;
  final List<String> tags;

  User copyWith(
      {String uid, String username, String photoUrl, List<String> tags}) {
    return User(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      photoUrl: photoUrl ?? this.photoUrl,
      tags: tags ?? this.tags,
    );
  }

  UserEntity toEntity() {
    return UserEntity(uid, username, photoUrl, tags);
  }

  static User fromEntity(UserEntity entity) {
    return User(
      uid: entity.uid,
      username: entity.username,
      photoUrl: entity.photoUrl,
      tags: entity.tags,
    );
  }
}
