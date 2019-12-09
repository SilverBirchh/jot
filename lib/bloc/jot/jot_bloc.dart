import 'dart:async';
import 'package:Jot/api/jot.dart';
import 'package:Jot/data/jot/jot_model.dart';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class JotBloc extends Bloc<JotEvent, JotState> {
  JotBloc(this.jotApi);

  final JotApiBase jotApi;

  StreamSubscription<List<Jot>> _streamSubscription;

  @override
  JotState get initialState => InitialJotState();

  @override
  Stream<JotState> mapEventToState(
    JotEvent event,
  ) async* {
    if (event is AddJot) {
      yield* _addJotToState(event);
    } else if (event is DeleteJot) {
      yield* _deleteJotToState(event);
    } else if (event is UpdateJot) {
      yield* _updateJotToState(event);
    } else if (event is StreamJots) {
      yield LoadingJots();
      yield* _mapLoadAllPanelsToState(event);
    } else if (event is JotListUpdated) {
      yield* _mapJotsUpdateToState(event);
    } else if (event is StreamJotsByDate) {
      yield* _mapJotsByDateToState(event);
    }
  }

  Stream<JotState> _mapLoadAllPanelsToState(StreamJots event) async* {
    try {
      _streamSubscription?.cancel();
      _streamSubscription = jotApi.jots(event.userId).listen(
        (List<Jot> jots) {
          add(
            JotListUpdated(jots),
          );
        },
      );
    } catch (e) {
      yield ErrorJots();
    }
  }

  Stream<JotState> _mapJotsByDateToState(StreamJotsByDate event) async* {
    final DateTime toDate =
        event.toDate == null ? DateTime.now() : event.toDate;
    final DateTime fromDate =
        event.fromDate == null ? DateTime(1980) : event.fromDate;
    try {
      _streamSubscription?.cancel();
      _streamSubscription =
          jotApi.jotsByDates(event.userId, toDate, fromDate).listen(
        (List<Jot> jots) {
          add(
            JotListUpdated(jots),
          );
        },
      );
    } catch (e) {
      yield ErrorJots();
    }
  }

  Stream<JotState> _mapJotsUpdateToState(JotListUpdated event) async* {
    yield LoadedJots(jots: event.jots);
  }

  Stream<JotState> _addJotToState(AddJot event) async* {
    jotApi.addJot(event.jot);
  }

  Stream<JotState> _deleteJotToState(DeleteJot event) async* {
    jotApi.deleteJot(event.jotId);
  }

  Stream<JotState> _updateJotToState(UpdateJot event) async* {
    jotApi.updateJot(event.jot);
  }
}
