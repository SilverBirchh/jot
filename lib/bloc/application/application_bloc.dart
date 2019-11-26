import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:bloc/bloc.dart';
import 'package:Jot/bloc/application/bloc.dart';
import 'package:Jot/data/user/user_model.dart';
import 'package:Jot/api/authenticate.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  ApplicationBloc({@required this.authentication});

  final AuthenticationBase authentication;

  @override
  ApplicationState get initialState => Uninitialized(null);

  @override
  Stream<ApplicationState> mapEventToState(ApplicationEvent event) async* {
    if (event is InitialiseUser) {
      try {
        yield Loading(state.user);
        await authentication.initialiseFirebaseUser(event.user);
        yield Initialized(user: event.user);
      } catch (error) {
        print('Initialisation Error');
      }
    } else if (event is CheckIsAuthenticated) {
      yield Loading(state.user);
      final User authenticatedUser = await authentication.isAuthenticated();
      if (authenticatedUser == null) {
        yield Uninitialized(null);
      } else {
        yield Initialized(user: authenticatedUser);
      }
    } else if (event is UninitialiseUser) {
      yield Uninitialized(null);
    } else if (event is UpdateUser) {
      yield Initialized(user: event.user);
    }
  }
}
