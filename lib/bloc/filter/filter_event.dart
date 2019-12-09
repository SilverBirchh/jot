import 'package:meta/meta.dart';

@immutable
abstract class FilterEvent {}

class UpdateFilters extends FilterEvent {
  UpdateFilters(
      {this.inportantOnly, this.tagsToApply, this.toDate, this.fromDate});
  final bool inportantOnly;
  final DateTime toDate;
  final DateTime fromDate;
  final List<String> tagsToApply;
}
