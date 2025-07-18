import 'package:flutter/material.dart';
import 'package:todo_list/models/task_model.dart';
import 'package:todo_list/enum/priority_enum.dart';

class UpdateProvider with ChangeNotifier {
  late TaskModel _task;
  final titleController = TextEditingController();
  final descController = TextEditingController();
  TaskModel get task => _task;

  void setTask(TaskModel task) {
    _task = task;
    titleController.text = task.title;
    descController.text = task.descrip;
  }

  void updateDate(DateTime date) {
    _task.date = date;
    notifyListeners();
  }

  void updateTimeStart(DateTime time) {
    _task.startTime = time;
    notifyListeners();
  }

  void updateTimeEnd(DateTime time) {
    _task.endTime = time;
    notifyListeners();
  }

  void setPriority(PriorityEnum priority) {
    selectedPriority = label(priority);
    notifyListeners();
  }

  void updatePriority(PriorityEnum priority) {
    _task.priority = priority;
    notifyListeners();
  }

  void saveChanges() {
    _task.title = titleController.text;
    _task.descrip = descController.text;
    // Aquí normalmente actualizarías en tu base de datos
    notifyListeners();
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }
}
