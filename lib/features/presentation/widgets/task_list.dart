import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/notifiers/task_notifier.dart';
import 'task_card.dart';

class TaskList extends ConsumerWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Chỉ có 1 state duy nhất
    final taskState = ref.watch(taskProvider);

    if (taskState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (taskState.tasks.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.task_alt, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              'No tasks yet',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Tap + to add a new task',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: taskState.tasks.length,
      padding: EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final task = taskState.tasks[index];
        return TaskCard(key: ValueKey(task.id), task: task);
      },
    );
  }
}
