import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateAndTimePicker {
  DateAndTimePicker({required this.context, required this.dateTime});

  final BuildContext context;
  final void Function(String) dateTime;

  Future<void> selectDateAndTime() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );

    if (pickedDate == null) return;

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime == null) return;

    final DateTime pickedDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    final String formattedDateTime =
        DateFormat('yyyy-MM-dd HH:mm').format(pickedDateTime);

    dateTime(formattedDateTime);
  }
}
