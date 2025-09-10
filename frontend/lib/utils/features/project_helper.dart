import '../../model/project.dart';

class ProjectHelpers {
  static List<Project> filterProjects(
    List<Project> projects,
    String searchQuery,
    String statusFilter,
  ) {
    return projects.where((project) {
      final matchesSearch =
          project.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
          project.description.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesStatus =
          statusFilter == 'all' || project.status == statusFilter;
      return matchesSearch && matchesStatus;
    }).toList();
  }

  static String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
