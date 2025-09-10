import 'package:flutter/material.dart';

import '../model/task.dart';

class TaskNotifier extends ChangeNotifier {
  final List<Task> _tasks = [];

  List<Task> get tasks => List.unmodifiable(_tasks);

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void updateTask(Task task) {
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = task;
      notifyListeners();
    }
  }

  void removeTask(String id) {
    _tasks.removeWhere((t) => t.id == id);
    notifyListeners();
  }
}

extension TaskNotifierExtension on TaskNotifier {
  List<Task> getTasksForProject(String projectId) {
    return _tasks.where((t) => t.projectId == projectId).toList();
  }

  void addSampleData() {
    addTask(
      Task(
        id: '1b9d6bcd-bbfd-4b2d-9b5d-ab8dfbbd4bed',
        projectId: '550e8400-e29b-41d4-a716-446655440000',
        title: 'Task 1',
        description: 'Sample task for Project 1',
        status: 'todo',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
    addTask(
      Task(
        id: '2c0e7cde-ccee-4c3e-9c6e-bc9egghh4cef',
        projectId: 'a1b2c3d4-e5f6-4g7h-8i9j-0k1l2m3n4o5p',
        title: 'Task 2',
        description: 'Sample task for Project 2',
        status: 'in_progress',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
  }
}
