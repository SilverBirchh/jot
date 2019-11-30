import 'package:meta/meta.dart';

@immutable
abstract class FilterState {
  FilterState({this.inportantOnly, this.tagsToApply});

  final List<String> tagsToApply;
  final bool inportantOnly;
}

class Filters extends FilterState {
  Filters({bool inportantOnly, List<String> tagsToApply})
      : super(inportantOnly: inportantOnly, tagsToApply: tagsToApply);
}
