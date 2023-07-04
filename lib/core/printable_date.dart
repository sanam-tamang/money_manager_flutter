import 'get_month.dart';

class PrintableDate {
  static String yearMonthDay(DateTime date) {
    final String day = date.day.toString();
    final String month = getMonthInString(date.month);
    final String year = date.year.toString();
    return '$day $month $year';
  }

  static String monthDay(DateTime date) {
    final String day = date.day.toString();
    final String month = getMonthInString(date.month);
    return '$day $month';
  }

  static String yearMonth(DateTime date) {
    final String month = getMonthInString(date.month);
    final String year = date.year.toString();
    return '$month $year';
  }
}
