enum Period { TODAY, YESTERDAY, THIS_WEEK, THIS_MONTH, DATE }

class TimePeriod {
  List<Period> get timePeriods => Period.values;

  Period currentPeriod = Period.TODAY;

  DateTime otherDate = DateTime.now();

  bool isImportant = false;

  String typeToString(Period period) {
    if (period == Period.TODAY) {
      return 'Today';
    } else if (period == Period.YESTERDAY) {
      return 'Yesyerday';
    } else if (period == Period.THIS_WEEK) {
      return 'This Week';
    } else if (period == Period.THIS_MONTH) {
      return 'This Month';
    } else if (period == Period.DATE) {
      return 'Specific Date';
    } else {
      return '';
    }
  }
}
