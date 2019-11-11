import 'package:flutter/foundation.dart';
import 'package:Jot/data/user/user_model.dart';

abstract class ApplicationEvent {}

class InitialiseUser extends ApplicationEvent {
  InitialiseUser({@required this.user});

  final User user;
}

class CheckIsAuthenticated extends ApplicationEvent {
  CheckIsAuthenticated();
}

class UninitialiseUser extends ApplicationEvent {}
