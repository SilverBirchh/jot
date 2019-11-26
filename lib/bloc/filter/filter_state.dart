import 'package:meta/meta.dart';

@immutable
abstract class FilterState {
  FilterState({this.inportantOnly});

  final bool inportantOnly;
}

class Filters extends FilterState {
  Filters({bool inportantOnly}) : super(inportantOnly: inportantOnly);
}
