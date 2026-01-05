import 'package:tasky/feature/home/domain/entities/task_entity.dart';

class TaskDto {
  static String collection = "tasks";
  String? id;
  String? title;
  String? description;
  DateTime? date;
  int? priority;
  bool? isCompleted;

  TaskDto({
    this.id,
    this.title,
    this.description,
    this.date,
    this.priority,
    this.isCompleted = false,
  });

  Map<String, dynamic> toJson() {
    final normaldate = DateTime(date!.year, date!.month, date!.day);
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': normaldate.millisecondsSinceEpoch,
      'priority': priority,
      'isCompleted': isCompleted,
    };
  }

  factory TaskDto.fromJson(Map<String, dynamic> json, String id) {
    return TaskDto(
      id: id,
      title: json['title'],
      description: json['description'],
      date: json['date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['date'])
          : null,
      priority: json['priority'],
      isCompleted: json['isCompleted'] ?? false,
    );
  }
  TaskEntity toEntity()=>TaskEntity(id: id,title: title,description: description,date: date,priority: priority,
  isCompleted: isCompleted ??false
  );
}
