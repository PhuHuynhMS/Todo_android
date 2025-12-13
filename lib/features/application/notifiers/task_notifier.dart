import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/task.dart';
import '../state/task_state.dart';

class TaskNotifier extends StateNotifier<TaskState> {
  TaskNotifier() : super(const TaskState()) {
    _initializeTasks();
  }

  // Khởi tạo tasks mẫu
  void _initializeTasks() {
    final initialTasks = [
      Task(
        id: '1',
        title: 'Complete Flutter project',
        description: 'Finish the todo app',
        isCompleted: false,
        createdAt: DateTime.now(),
        priority: TaskPriority.urgent,
      ),
      Task(
        id: '2',
        title: 'Review code',
        description: 'Review pull requests',
        isCompleted: false,
        createdAt: DateTime.now(),
        priority: TaskPriority.high,
      ),
      Task(
        id: '3',
        title: 'Write documentation',
        description: 'Update README file',
        isCompleted: true,
        createdAt: DateTime.now(),
        priority: TaskPriority.low,
      ),
    ];
    state = state.copyWith(tasks: initialTasks);
  }

  // Thêm task mới
  void addTask(Task task) {
    state = state.copyWith(tasks: [...state.tasks, task]);
  }

  // Xóa task
  void deleteTask(String taskId) {
    state = state.copyWith(
      tasks: state.tasks.where((task) => task.id != taskId).toList(),
    );
  }

  // Toggle trạng thái complete của task
  void toggleTaskComplete(String taskId) {
    state = state.copyWith(
      tasks: state.tasks.map((task) {
        if (task.id == taskId) {
          return task.copyWith(isCompleted: !task.isCompleted);
        }
        return task;
      }).toList(),
    );
  }

  // Cập nhật task
  void updateTask(Task updatedTask) {
    state = state.copyWith(
      tasks: state.tasks.map((task) {
        if (task.id == updatedTask.id) {
          return updatedTask;
        }
        return task;
      }).toList(),
    );
  }

  // Xóa tất cả completed tasks
  void clearCompletedTasks() {
    state = state.copyWith(
      tasks: state.tasks.where((task) => !task.isCompleted).toList(),
    );
  }
}

// Provider cho TaskNotifier - SINGLE SOURCE OF TRUTH
final taskProvider = StateNotifierProvider<TaskNotifier, TaskState>((ref) {
  return TaskNotifier();
});
