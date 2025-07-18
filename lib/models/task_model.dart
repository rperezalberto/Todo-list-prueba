// lib/models/task_model.dart
class TaskModel {
  int? id;
  String title;
  String descrip;
  DateTime date;
  DateTime startTime;
  DateTime endTime;
  String priority;

  TaskModel({
    this.id,
    required this.title,
    required this.descrip,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.priority,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'descrip': descrip,
      'date': date.toIso8601String(),
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'priority': priority,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['title'],
      descrip: map['descrip'],
      date: DateTime.parse(map['date']),
      startTime: DateTime.parse(map['startTime']),
      endTime: DateTime.parse(map['endTime']),
      priority: map['priority'],
    );
  }
}
