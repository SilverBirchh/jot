import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  @override
  FilterState get initialState =>
      Filters(inportantOnly: false, tagsToApply: <String>[]);

  @override
  Stream<FilterState> mapEventToState(
    FilterEvent event,
  ) async* {
    if (event is UpdateFilters) {
      yield Filters(
          inportantOnly: event.inportantOnly, tagsToApply: event.tagsToApply);
    }
  }
}
