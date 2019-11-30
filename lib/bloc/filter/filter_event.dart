import 'package:meta/meta.dart';

@immutable
abstract class FilterEvent {}

class UpdateFilters extends FilterEvent {
  UpdateFilters({this.inportantOnly, this.tagsToApply});
  final bool inportantOnly;
  final List<String> tagsToApply;
}
