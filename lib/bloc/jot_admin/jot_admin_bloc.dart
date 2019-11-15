import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class JotAdminBloc extends Bloc<JotAdminEvent, JotAdminState> {
  @override
  JotAdminState get initialState => InitialJotAdminState();

  @override
  Stream<JotAdminState> mapEventToState(
    JotAdminEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
