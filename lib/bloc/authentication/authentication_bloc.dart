import 'dart:async';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:Jot/bloc/authentication/bloc.dart';
import 'package:Jot/api/authenticate.dart';
import 'package:Jot/data/user/user_model.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({@required this.authentication});

  AuthenticationBase authentication;

  @override
  AuthenticationState get initialState => const Empty();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is SignIn) {
      try {
        final User user = await authentication.signIn();
        yield Success(user);
      } catch (error) {
        yield const AuthenticationError();
      }
    }
  }
}
