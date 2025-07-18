import 'package:intl/intl.dart';

String formatTime(DateTime time) {
  final hour = time.hour.toString().padLeft(2, '0');
  final minute = time.minute.toString().padLeft(2, '0');
  // final period = time.hour >= 12 ? 'PM' : 'AM';
  return '$hour : $minute';
}

String currentMonth(selectedDate) {
  return DateFormat('MMMM yyyy', 'es_ES').format(selectedDate);
}
