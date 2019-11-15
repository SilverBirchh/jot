import 'package:Jot/data/jot/jot_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class JotState {}

class InitialJotState extends JotState {}

class LoadingJots extends JotState {}

class ErrorJots extends JotState {}

class LoadedJots extends JotState {
  LoadedJots(this.jots);
  final List<Jot> jots;
}
