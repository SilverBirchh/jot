import 'package:Jot/data/jot/jot_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class JotEvent {}

class AddJot extends JotEvent {
  AddJot(this.jot);

  final Jot jot;
}

class DeleteJot extends JotEvent {
  DeleteJot(this.jotId);

  final String jotId;
}

class UpdateJot extends JotEvent {
  UpdateJot(this.jot);

  final Jot jot;
}

class StreamJots extends JotEvent {
  StreamJots(this.userId);

  final String userId;
}

class StreamMoreJots extends JotEvent {
  StreamMoreJots(this.userId);

  final String userId;
}

class JotListUpdated extends JotEvent {
  JotListUpdated(this.jots);
  final List<Jot> jots;

  @override
  String toString() => 'PanelsUpdated';
}
