import 'package:flutter/material.dart';

import '../model/project.dart';

class ProjectNotifier extends ChangeNotifier {
  final List<Project> _projects = [];

  List<Project> get projects => List.unmodifiable(_projects);

  void addProject(Project project) {
    _projects.add(project);
    notifyListeners();
  }

  void updateProject(Project project) {
    final index = _projects.indexWhere((p) => p.id == project.id);
    if (index != -1) {
      _projects[index] = project;
      notifyListeners();
    }
  }

  void removeProject(String id) {
    _projects.removeWhere((p) => p.id == id);
    notifyListeners();
  }
}
