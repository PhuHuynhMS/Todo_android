import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/task.dart';
import '../../application/notifiers/task_notifier.dart';
import 'custom_chip.dart';

class TaskCard extends ConsumerWidget {
  final Task task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Debug: In ra dueDate
    debugPrint('Task ${task.id}: dueDate = ${task.dueDate}');

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Checkbox(
          value: task.isCompleted,
          onChanged: (value) {
            ref.read(taskProvider.notifier).toggleTaskComplete(task.id);
          },
        ),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (task.description.isNotEmpty) ...[
              Text(task.description),
              const SizedBox(height: 4),
            ],
            Row(
              children: [
                _buildPriorityChip(task.priority),
                if (task.dueDate != null) ...[
                  const SizedBox(width: 12),
                  Expanded(child: _buildDueDateInfo(task)),
                ],
              ],
            ),
          ],
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

  Widget _buildDueDateInfo(Task task) {
    final dueDate = task.dueDate!;
    final formatter = DateFormat('dd/MM HH:mm');
    final dateText = formatter.format(dueDate);

    Color color;
    IconData icon;

    if (task.isOverdue) {
      // Quá hạn
      color = Colors.red;
      icon = Icons.warning;
    } else if (task.isDueSoon) {
      // Sắp đến hạn (trong 24h)
      color = Colors.orange;
      icon = Icons.schedule;
    } else {
      // Bình thường
      color = Colors.green;
      icon = Icons.calendar_today;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(
          dateText,
          style: TextStyle(
            fontSize: 12,
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
