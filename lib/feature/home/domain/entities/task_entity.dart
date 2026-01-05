class TaskEntity {
  final String? id;
  final String? title;
  final String? description;
  final DateTime? date;
  final int? priority;
  final bool isCompleted;

  const TaskEntity({
    this.id,
    this.title,
    this.description,
    this.date,
    this.priority,
    this.isCompleted = false,
  });

  TaskEntity copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? date,
    int? priority,
    bool? isCompleted,
  }) {
    return TaskEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      priority: priority ?? this.priority,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
