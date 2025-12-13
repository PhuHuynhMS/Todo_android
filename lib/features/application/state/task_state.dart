import 'package:flutter/foundation.dart';
import '../../domain/entities/task.dart';

@immutable
class TaskState {
  final List<Task> tasks;
  final bool isLoading;
  final String? error;

  const TaskState({this.tasks = const [], this.isLoading = false, this.error});

  TaskState copyWith({List<Task>? tasks, bool? isLoading, String? error}) {
    return TaskState(
      tasks: tasks ?? this.tasks,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  // Getters để tính toán derived state
  int get activeTasks => tasks.where((task) => !task.isCompleted).length;
  int get completedTasks => tasks.where((task) => task.isCompleted).length;
}
