import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class JotBloc extends Bloc<JotEvent, JotState> {
  @override
  JotState get initialState => InitialJotState();

  @override
  Stream<JotState> mapEventToState(
    JotEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
