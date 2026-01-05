import 'package:flutter/material.dart';
import 'package:tasky/feature/home/domain/entities/task_entity.dart';
import 'package:tasky/feature/home/presentation/widgets/item_card.dart';

class CompletedTaskWidgets extends StatelessWidget {
  final List<TaskEntity> tasks;
  final Function(TaskEntity, bool) onToggleComplete;
  const CompletedTaskWidgets({
    super.key,
    required this.tasks,
    required this.onToggleComplete,
  });


  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) return const SizedBox.shrink();

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tasks.length,
      separatorBuilder: (_, __) => const SizedBox(height: 5),
      itemBuilder: (context, index) {
        final task = tasks[index];
        return ItemCardWidgets(
          title: task.title ??"",
          iscompleted: task.isCompleted,
          priority: task.priority ??0,
          dateTime: task.date ??DateTime.now(),
          onpressed: (value) {
            onToggleComplete(task, value);
          },
        );
      },
    );
  }
}
