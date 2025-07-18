import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_list/models/task_model.dart';
import 'package:todo_list/services/DBServices.dart';

class TaksProvider with ChangeNotifier {
  List<TaskModel> _tasks = [];
  List<TaskModel> get tasks => _tasks;
  DBService dbService = DBService();

  bool _loaded = false;
  bool get isLoaded => _loaded;

  Future<void> loadTasks() async {
    _tasks = await dbService.getTasks();
    notifyListeners();
  }

  Future<void> deleteTask(int id) async {
    try {
      await dbService.deleteTaskServices(id);
      await loadTasks();
      notifyListeners(); // actualiza la UI
    } catch (e) {
      log("Error al borrar el task: $e");
    }
  }

  Color getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'alta':
        return Color(0xFFFACBBA);
      case 'media':
        return Color(0xFFD7F0FF);
      case 'baja':
        return Colors.green;
      default:
        return Color(0xFFFAD9FF);
    }
  }
}
