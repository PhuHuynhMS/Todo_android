import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/entities/task.dart';
import '../state/task_state.dart';

class TaskNotifier extends StateNotifier<TaskState> {
  // Getter để lấy box (lazy access)
  Box<Task> get _taskBox => Hive.box<Task>('tasks');

  TaskNotifier() : super(const TaskState()) {
    _loadTasks();
  }

  // Load tasks từ Hive
  void _loadTasks() {
    final tasks = _taskBox.values.toList();
    state = state.copyWith(tasks: tasks);

    // Nếu chưa có task nào, tạo tasks mẫu
    if (tasks.isEmpty) {
      _initializeSampleTasks();
    }
  }

  // Khởi tạo tasks mẫu (chỉ chạy 1 lần khi app mới cài)
  void _initializeSampleTasks() {
    final now = DateTime.now();
    final initialTasks = [
      Task(
        id: '1',
        title: 'Complete Flutter project',
        description: 'Finish the todo app',
        isCompleted: false,
        createdAt: now,
        priority: TaskPriority.urgent,
        dueDate: now.add(const Duration(hours: 12)),
      ),
      Task(
        id: '2',
        title: 'Review code',
        description: 'Review pull requests',
        isCompleted: false,
        createdAt: now,
        priority: TaskPriority.high,
        dueDate: now.add(const Duration(days: 2)),
      ),
      Task(
        id: '3',
        title: 'Write documentation',
        description: 'Update README file',
        isCompleted: true,
        createdAt: now.subtract(const Duration(days: 1)),
        priority: TaskPriority.low,
        dueDate: now.subtract(const Duration(hours: 2)),
      ),
    ];

    for (var task in initialTasks) {
      _taskBox.put(task.id, task);
    }

    state = state.copyWith(tasks: initialTasks);
  }

  // Thêm task mới
  void addTask(Task task) {
    _taskBox.put(task.id, task);
    final updatedTasks = [...state.tasks, task];
    state = state.copyWith(tasks: updatedTasks);
  }

  // Xóa task
  void deleteTask(String taskId) {
    _taskBox.delete(taskId);
    final updatedTasks = state.tasks
        .where((task) => task.id != taskId)
        .toList();
    state = state.copyWith(tasks: updatedTasks);
  }

  // Toggle trạng thái complete của task
  void toggleTaskComplete(String taskId) {
    final updatedTasks = state.tasks.map((task) {
      if (task.id == taskId) {
        final updatedTask = task.copyWith(isCompleted: !task.isCompleted);
        _taskBox.put(taskId, updatedTask);
        return updatedTask;
      }
      return task;
    }).toList();

    state = state.copyWith(tasks: updatedTasks);
  }

  // Cập nhật task
  void updateTask(Task updatedTask) {
    _taskBox.put(updatedTask.id, updatedTask);
    final updatedTasks = state.tasks.map((task) {
      if (task.id == updatedTask.id) {
        return updatedTask;
      }
      return task;
    }).toList();

    state = state.copyWith(tasks: updatedTasks);
  }

  // Xóa tất cả completed tasks
  void clearCompletedTasks() {
    final completedTaskIds = state.tasks
        .where((task) => task.isCompleted)
        .map((task) => task.id)
        .toList();

    for (var id in completedTaskIds) {
      _taskBox.delete(id);
    }

    final updatedTasks = state.tasks
        .where((task) => !task.isCompleted)
        .toList();
    state = state.copyWith(tasks: updatedTasks);
  }
}

// Provider cho TaskNotifier - SINGLE SOURCE OF TRUTH
final taskProvider = StateNotifierProvider<TaskNotifier, TaskState>((ref) {
  return TaskNotifier();
});
