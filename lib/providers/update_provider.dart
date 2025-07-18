import 'package:flutter/material.dart';
import 'package:todo_list/models/task_model.dart';
import 'package:todo_list/enum/priority_enum.dart';
import 'package:todo_list/services/DBServices.dart';

class UpdateProvider with ChangeNotifier {
  DBService dbService = DBService();
  DateTime selectedDate = DateTime.now();
  late TaskModel _task;
  late PriorityEnum selectedPriority = PriorityEnum.medium;
  final titleController = TextEditingController();
  final descController = TextEditingController();
  DateTime selectedTimeStart = DateTime.now();
  DateTime selectedTimeEnd = DateTime.now();
  TaskModel get task => _task;

  void setTask(TaskModel task) {
    _task = task;
    // Convertimos el string a PriorityEnum

    titleController.text = task.title;
    descController.text = task.descrip;
    selectedDate = task.date;
    selectedTimeStart = task.startTime;
    selectedTimeEnd = task.endTime;

    selectedPriority = priorityFromString(task.priority);
    notifyListeners();
  }

  Future<void> update(int id) async {
    final newTaks = TaskModel(
      id: id,
      title: titleController.text,
      descrip: descController.text,
      date: selectedDate,
      startTime: selectedTimeStart,
      endTime: selectedTimeEnd,
      priority: selectedPriority.label,
    );
    dbService.updateTaskSerices(newTaks);
    notifyListeners();
  }

  void currentSelectedDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  void setPriority(PriorityEnum priority) {
    selectedPriority = priority;
    notifyListeners();
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }
}
