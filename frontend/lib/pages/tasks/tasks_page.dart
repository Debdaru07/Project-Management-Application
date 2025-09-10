import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../model/task.dart';
import '../../notifiers/project_notifier.dart';
import '../../notifiers/task_notifier.dart';
import '../../utils/components/app_button.dart';
import '../../utils/components/app_searchable_dropdowns.dart';
import '../../utils/components/app_textfield.dart';
import '../../utils/theme/app_palette.dart';

class TasksPage extends StatefulWidget {
  final String projectId;

  const TasksPage({super.key, required this.projectId});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedStatus = 'all';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _updateTaskStatus(String taskId, String newStatus) {
    final notifier = context.read<TaskNotifier>();
    final task = notifier.tasks.firstWhere((t) => t.id == taskId);
    final updatedTask = Task(
      id: task.id,
      projectId: task.projectId,
      title: task.title,
      description: task.description,
      status: newStatus,
      createdAt: task.createdAt,
      updatedAt: DateTime.now(),
    );
    notifier.updateTask(updatedTask);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ProjectNotifier, TaskNotifier>(
      builder: (context, projectNotifier, taskNotifier, child) {
        final project = projectNotifier.projects.firstWhere(
          (p) => p.id == widget.projectId,
          orElse: () => throw Exception('Project not found'),
        );
        final tasks = taskNotifier.getTasksForProject(widget.projectId);
        final filteredTasks = ProjectHelpers.filterTasks(
          tasks,
          _searchController.text,
          _selectedStatus,
        );

        return Scaffold(
          backgroundColor: AppPalette.magnolia,
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.pop(),
            ),
            title: Text('Tasks - ${project.title}'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        label: 'Search Tasks',
                        controller: _searchController,
                        hint: 'Enter task title...',
                        onChanged: (_) => setState(() {}),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: AppSearchableDropdown<String>(
                        items: ['all', 'todo', 'in_progress', 'completed'],
                        label: 'Filter by Status',
                        initialValue: 'all',
                        itemAsString: (status) => status,
                        onChanged:
                            (value) => setState(
                              () => _selectedStatus = value ?? 'all',
                            ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredTasks.length,
                    itemBuilder: (context, index) {
                      final task = filteredTasks[index];
                      return ListTile(
                        title: Text(task.title),
                        subtitle: Text(
                          task.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: PopupMenuButton<String>(
                          onSelected:
                              (value) => _updateTaskStatus(task.id, value),
                          itemBuilder:
                              (context) => [
                                if (task.status != 'completed')
                                  const PopupMenuItem(
                                    value: 'completed',
                                    child: Text('Mark as Completed'),
                                  ),
                                if (task.status != 'done')
                                  const PopupMenuItem(
                                    value: 'done',
                                    child: Text('Mark as Done'),
                                  ),
                              ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: AppButton(
                    text: 'Add Task',
                    onPressed:
                        () => context.push('/add-task/${widget.projectId}'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ProjectHelpers {
  static List<Task> filterTasks(
    List<Task> tasks,
    String searchQuery,
    String statusFilter,
  ) {
    return tasks.where((task) {
      final matchesSearch =
          task.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
          task.description.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesStatus =
          statusFilter == 'all' || task.status == statusFilter;
      return matchesSearch && matchesStatus;
    }).toList();
  }
}
