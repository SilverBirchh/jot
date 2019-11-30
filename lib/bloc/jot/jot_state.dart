import 'package:Jot/data/jot/jot_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class JotState {}

class InitialJotState extends JotState {}

class LoadingJots extends JotState {}

class ErrorJots extends JotState {}

class LoadedJots extends JotState {
  LoadedJots({this.jots, this.hasReachedMax});
  final List<Jot> jots;
  final bool hasReachedMax;

  LoadedJots copyWith({
    List<Jot> jots,
    bool hasReachedMax,
  }) {
    return LoadedJots(
      jots: jots ?? this.jots,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}
