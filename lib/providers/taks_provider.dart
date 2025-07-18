import 'dart:developer';

// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:share_plus/share_plus.dart';
import 'package:todo_list/models/task_model.dart';
import 'package:todo_list/services/DBServices.dart';
import 'package:excel/excel.dart';
import 'dart:io';

class TaksProvider with ChangeNotifier {
  List<TaskModel> _tasks = [];
  List<TaskModel> get tasks => _tasks;
  DBService dbService = DBService();
  TextEditingController searchController = TextEditingController();
  String _searchQuery = '';
  String get searchQuery => _searchQuery;

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

// Buscardor
  List<TaskModel> get filteredTasks {
    if (_searchQuery.trim().isEmpty || _tasks.isEmpty) return _tasks;

    final queryWords = _searchQuery
        .toLowerCase()
        .split(' ')
        .where((w) => w.isNotEmpty)
        .toList();

    return _tasks.where((task) {
      final title = task.title.toLowerCase();
      final descrip = task.descrip.toLowerCase();
      return queryWords.every(
        (word) => title.contains(word) || descrip.contains(word),
      );
    }).toList();
  }

  void updateSearchQuery(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  void clearSearch() {
    searchController.clear();
    updateSearchQuery('');
  }

  Future<void> exportarTareasAExcel() async {
    final excel = Excel.createExcel();
    final sheet = excel['Tareas'];

    // Encabezados
    sheet.appendRow([
      'Título',
      'Descripción',
      'Fecha',
      'Hora Inicio',
      'Hora Fin',
      'Prioridad',
    ]);

    // Datos de tareas
    for (var tarea in _tasks) {
      sheet.appendRow([
        tarea.title,
        tarea.descrip,
        tarea.date,
        tarea.startTime,
        tarea.endTime,
        tarea.priority,
      ]);
    }

    // Guardar archivo
    final bytes = excel.encode();
    if (bytes == null) return;

    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/tareas_exportadas.xlsx';
    final file = File(filePath)
      ..createSync(recursive: true)
      ..writeAsBytesSync(bytes);

    log('Archivo guardado en: $filePath');

    // Compartir archivo
    await Share.shareXFiles(
      [XFile(filePath)],
      text: 'Aquí está el archivo Excel de tareas 📄',
    );
  }
}
