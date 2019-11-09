import 'package:flutter/foundation.dart';
import 'package:Jot/data/user/user_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationState {
  const AuthenticationState(this.user) : super();

  final User user;
}

class Empty extends AuthenticationState {
  const Empty() : super(null);
}

class Authenticating extends AuthenticationState {
  const Authenticating() : super(null);
}

class AuthenticationError extends AuthenticationState {
  const AuthenticationError() : super(null);
}

class Success extends AuthenticationState {
  const Success(User user)
      : assert(user != null),
        super(user);
}
