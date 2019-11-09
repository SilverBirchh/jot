import 'package:flutter/foundation.dart';
import 'package:Jot/data/user/user_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ApplicationState {
  const ApplicationState(this.user) : super();

  final User user;
}

class Uninitialized extends ApplicationState {
  const Uninitialized(User user) : super(user);
  @override
  String toString() => 'User uninitialized';
}

class Loading extends ApplicationState {
  const Loading(User user) : super(user);

  @override
  String toString() => 'Loading App';
}

class Error extends ApplicationState {
  const Error(User user, {@required this.error})
      : assert(error != null),
        super(user);

  final String error;
}

class Initialized extends ApplicationState {
  const Initialized({@required User user})
      : assert(user != null),
        super(user);

  @override
  String toString() => 'Initialized { username: ${user.username} }';
}
