import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/enum/priority_enum.dart';
import 'package:todo_list/models/task_model.dart';
import 'package:todo_list/providers/taks_provider.dart';
import 'package:todo_list/services/DBServices.dart';

class AddProvider with ChangeNotifier {
  DateTime selectedDate = DateTime.now();
  late List<DateTime> days;
  final TextEditingController title = TextEditingController();
  final TextEditingController descrip = TextEditingController();
  DateTime selectedTimeStart = DateTime.now();
  DateTime selectedTimeEnd = DateTime.now();
  PriorityEnum selectedPriority = PriorityEnum.medium;
  TaksProvider taksProvider = TaksProvider();

  final db = DBService();

  AddProvider() {
    _generateDaysForMonth(selectedDate);
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
          color: themeColor.surface,
          child: Column(
            children: [
              Container(
                color: themeColor.surface,
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

  void setPriority(PriorityEnum priority) {
    selectedPriority = priority;
    // selectedPriority = label(priority);
    notifyListeners();
  }

  Future<void> addTask() async {
    try {
      final task = TaskModel(
          title: title.text,
          descrip: descrip.text,
          date: selectedDate,
          startTime: selectedTimeStart,
          endTime: selectedTimeEnd,
          priority: selectedPriority.label);

      await db.insertTask(task);
      await taksProvider.loadTasks();
      notifyListeners();
    } catch (e) {
      log("Error al grear el taks");
    }
  }

  @override
  void dispose() {
    title.dispose();
    descrip.dispose();
    super.dispose();
  }
}
