import 'package:flutter/material.dart';
import '../model/task.dart';
import 'task_notifier.dart';

class TaskDetailNotifier extends ChangeNotifier {
  Task? _task;

  Task? get task => _task;

  /// Initialize with a given task
  void setTask(Task task) {
    _task = task;
    notifyListeners();
  }

  /// Update the task status
  void updateStatus(String newStatus) {
    if (_task == null) return;
    _task = Task(
      id: _task!.id,
      projectId: _task!.projectId,
      title: _task!.title,
      description: _task!.description,
      status: newStatus,
      createdAt: _task!.createdAt,
      updatedAt: DateTime.now(),
    );
    notifyListeners();
  }

  /// Update the description
  void updateDescription(String newDescription) {
    if (_task == null) return;
    _task = Task(
      id: _task!.id,
      projectId: _task!.projectId,
      title: _task!.title,
      description: newDescription,
      status: _task!.status,
      createdAt: _task!.createdAt,
      updatedAt: DateTime.now(),
    );
    notifyListeners();
  }

  /// Push updates back to global TaskNotifier
  void commitChanges(TaskNotifier taskNotifier) {
    if (_task == null) return;
    taskNotifier.updateTask(_task!);
  }
}
