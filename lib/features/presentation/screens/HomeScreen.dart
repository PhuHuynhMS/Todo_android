import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/notifiers/task_notifier.dart';
import '../widgets/todo_summary_counter.dart';
import '../widgets/task_list.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskState = ref.watch(taskProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Tasks"),
        titleSpacing: 16,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                TodoSummaryCounter(
                  activeCount: taskState.activeTasks,
                  completedCount: taskState.completedTasks,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: SearchBar(
                        padding: WidgetStateProperty.all(EdgeInsets.all(10)),
                        leading: const Icon(Icons.search),
                        hintText: "Search tasks...",
                        elevation: WidgetStateProperty.all(0),
                        textStyle: WidgetStateProperty.all(
                          Theme.of(context).textTheme.bodyMedium,
                        ),
                        onChanged: (value) {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: const TaskList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Mở dialog để thêm task mới
        },
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
