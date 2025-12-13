import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/task.dart';
import '../../application/notifiers/task_notifier.dart';
import 'custom_chip.dart';

class TaskCard extends ConsumerWidget {
  final Task task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Checkbox(
          value: task.isCompleted,
          onChanged: (value) {
            ref.read(taskProvider.notifier).toggleTaskComplete(task.id);
          },
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                task.title,
                style: TextStyle(
                  decoration: task.isCompleted
                      ? TextDecoration.lineThrough
                      : null,
                ),
              ),
            ),
            _buildPriorityChip(task.priority),
          ],
        ),
        subtitle: task.description.isNotEmpty ? Text(task.description) : null,
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline),
          onPressed: () {
            ref.read(taskProvider.notifier).deleteTask(task.id);
          },
        ),
      ),
    );
  }

  Widget _buildPriorityChip(TaskPriority priority) {
    Color color;
    IconData icon;

    switch (priority) {
      case TaskPriority.urgent:
        color = Colors.red;
        icon = Icons.priority_high;
        break;
      case TaskPriority.high:
        color = Colors.orange;
        icon = Icons.arrow_upward;
        break;
      case TaskPriority.medium:
        color = Colors.blue;
        icon = Icons.drag_handle;
        break;
      case TaskPriority.low:
        color = Colors.grey;
        icon = Icons.arrow_downward;
        break;
    }

    return CustomChip.display(
      label: priority.label,
      color: color,
      icon: icon,
      showIcon: true,
    );
  }
}
