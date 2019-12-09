import 'package:meta/meta.dart';

@immutable
abstract class FilterState {
  FilterState(
      {this.inportantOnly, this.tagsToApply, this.fromDate, this.toDate});

  final List<String> tagsToApply;
  final bool inportantOnly;
  final DateTime toDate;
  final DateTime fromDate;
}

class Filters extends FilterState {
  Filters(
      {bool inportantOnly,
      List<String> tagsToApply,
      DateTime toDate,
      DateTime fromDate})
      : super(
            inportantOnly: inportantOnly,
            tagsToApply: tagsToApply,
            fromDate: fromDate,
            toDate: toDate);
}
