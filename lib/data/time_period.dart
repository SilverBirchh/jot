enum Period { TODAY, YESTERDAY, THIS_WEEK, THIS_MONTH, DATE }

class TimePeriod {
  List<Period> get timePeriods => Period.values;

  Period stringToType(String period) {
    if (period == 'Today') {
      return Period.TODAY;
    } else if (period == 'Yesterday') {
      return Period.YESTERDAY;
    } else if (period == 'This Week') {
      return Period.THIS_WEEK;
    } else if (period == 'This Month') {
      return Period.THIS_MONTH;
    } else if (period == 'Specific Date') {
      return Period.DATE;
    } else {
      return null;
    }
  }

  String typeToString(Period period) {
    if (period == Period.TODAY) {
      return 'Today';
    } else if (period == Period.YESTERDAY) {
      return 'Yesterday';
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
