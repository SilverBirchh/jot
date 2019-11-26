import 'package:meta/meta.dart';

@immutable
abstract class FilterEvent {}

class UpdateFilters extends FilterEvent {
  UpdateFilters({this.inportantOnly});
  final bool inportantOnly;
}
