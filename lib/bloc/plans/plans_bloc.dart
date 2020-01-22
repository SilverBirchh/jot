import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class PlansBloc extends Bloc<PlansEvent, PlansState> {
  @override
  PlansState get initialState => InitialPlansState();

  @override
  Stream<PlansState> mapEventToState(
    PlansEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
