import 'package:intl/intl.dart';
import 'package:week_of_year/week_of_year.dart';

String formatDateTimeWithHourAndMinute(DateTime dateTime) {
  return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
}

String formatDateTime(DateTime dateTime) {
  return DateFormat('yyyy-MM-dd').format(dateTime);
}

String formatDateTimeYearOnly(DateTime dateTime) {
  return DateFormat('yyyy').format(dateTime);
}

String formatDateTimeYearandMonthOnly(DateTime dateTime) {
  return DateFormat('yyyy-MM').format(dateTime);
}

String formatDateTimeWithYearWeek(DateTime dateTime) {
  String year = formatDateTimeYearOnly(dateTime);
  return '$year-${dateTime.weekOfYear}';
}
