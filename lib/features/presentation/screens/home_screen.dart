import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/notifiers/task_notifier.dart';
import '../widgets/todo_summary_counter.dart';
import '../widgets/task_list.dart';
import '../widgets/add_task_dialog.dart';

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
        actions: [_buildMenuButton(), _buildMoreOptionsButton()],
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
                Row(children: [Expanded(child: _buildSearchBar(context))]),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(child: const TaskList()),
      floatingActionButton: _buildAddTaskButton(),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return SearchBar(
      padding: WidgetStateProperty.all(EdgeInsets.all(10)),
      leading: const Icon(Icons.search),
      hintText: "Search tasks...",
      elevation: WidgetStateProperty.all(0),
      textStyle: WidgetStateProperty.all(
        Theme.of(context).textTheme.bodyMedium,
      ),
      onChanged: (value) {},
    );
  }

  Widget _buildMenuButton() {
    return IconButton(
      onPressed: () {
        // Xử lý khi nhấn nút menu
      },
      icon: const Icon(Icons.menu),
    );
  }

  Widget _buildMoreOptionsButton() {
    return PopupMenuButton<String>(
      onSelected: (value) {
        // Xử lý lựa chọn từ menu
      },
      itemBuilder: (BuildContext context) {
        return {'Settings', 'Help', 'About'}.map((String choice) {
          return PopupMenuItem<String>(value: choice, child: Text(choice));
        }).toList();
      },
    );
  }

  Widget _buildAddTaskButton() {
    return Builder(
      builder: (context) => FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) => const AddTaskBottomSheet(),
          );
        },
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
