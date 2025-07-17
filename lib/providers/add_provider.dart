import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:intl/intl.dart';

class AddProvider with ChangeNotifier {
  DateTime selectedDate = DateTime.now();
  late List<DateTime> days;
  DateTime selectedTimeStart = DateTime.now();
  DateTime selectedTimeEnd = DateTime.now();
  AddProvider() {
    _generateDaysForMonth(selectedDate);
  }

  String get currentMonth {
    return DateFormat('MMMM yyyy', 'es_ES').format(selectedDate);
  }

  void currentSelectedDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  void _generateDaysForMonth(DateTime date) {
    // final firstDay = DateTime(date.year, date.month, 1);
    final lastDay = DateTime(date.year, date.month + 1, 0);

    days = List.generate(
      lastDay.day,
      (index) => DateTime(date.year, date.month, index + 1),
    );
  }

  void nextMonth() {
    selectedDate = DateTime(selectedDate.year, selectedDate.month + 1, 1);
    _generateDaysForMonth(selectedDate);
    notifyListeners();
  }

  void previousMonth() {
    selectedDate = DateTime(selectedDate.year, selectedDate.month - 1, 1);
    _generateDaysForMonth(selectedDate);
    notifyListeners();
  }

  String formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    // final period = time.hour >= 12 ? 'PM' : 'AM';
    return '$hour : $minute';
  }

  void showTimePicker(BuildContext context, DateTime initialTime,
      void Function(DateTime) onTimeSelected) {
    final themeColor = Theme.of(context).colorScheme;
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        DateTime tempPickedTime =
            initialTime; // temporal para no cambiar hasta aceptar

        return Container(
          height: 250,
          color: themeColor.onSecondary,
          child: Column(
            children: [
              Container(
                color: themeColor.onSecondary,
                height: 180,
                child: TimePickerSpinner(
                  is24HourMode: true,
                  normalTextStyle:
                      TextStyle(fontSize: 18, color: themeColor.secondary),
                  highlightedTextStyle:
                      TextStyle(fontSize: 24, color: themeColor.onPrimary),
                  spacing: 30,
                  itemHeight: 60,
                  isForce2Digits: true,
                  time: tempPickedTime,
                  onTimeChange: (time) {
                    tempPickedTime = time;
                    notifyListeners();
                  },
                ),
              ),
              TextButton(
                onPressed: () {
                  onTimeSelected(tempPickedTime);
                  notifyListeners();
                  Navigator.pop(context);
                },
                child: Text(
                  "Aceptar",
                  style: TextStyle(
                    color: themeColor.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
