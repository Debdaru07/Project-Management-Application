import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../model/task.dart';
import '../../notifiers/project_notifier.dart';
import '../../notifiers/task_notifier.dart';
import '../../utils/components/app_button.dart';
import '../../utils/components/app_data_table.dart';
import '../../utils/components/app_linear_progress_indicator.dart';
import '../../utils/components/app_searchable_dropdowns.dart';
import '../../utils/components/app_textfield.dart';
import '../../utils/features/project_helper.dart';
import '../../utils/theme/app_palette.dart';
import '../../utils/theme/app_palette.dart' as palette;
import '../../utils/theme/app_text_styles.dart';

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
        final filteredTasks = TaskHelpers.filterTasks(
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
            title: Text(
              project.title,
              style: AppTextStyles.bodyLarge.copyWith(
                color: palette.AppPalette.raisinBlack,
              ),
            ),
            actions: [
              AppButton(
                text: 'Add Task',
                margin: const EdgeInsets.all(8),
                backgroundColor: AppPalette.magnolia,
                borderRadius: 16,
                textstyle: AppTextStyles.bodyMedium.copyWith(
                  color: palette.AppPalette.resolutionBlue,
                ),
                prefixIcon: Icon(
                  Icons.add,
                  color: AppPalette.resolutionBlue,
                  size: 18,
                ),
                onPressed: () => context.push('/add-task/${widget.projectId}'),
              ),
              const SizedBox(width: 24),
            ],
          ),
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
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
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.96,
                    child: AppDataTable(
                      columns: const [
                        'Title',
                        'Description',
                        'Status',
                        'Progress',
                        'Created At',
                        'Actions',
                      ],
                      rows:
                          filteredTasks.map((task) {
                            return {
                              'Title': task.title,
                              'Description': task.description,
                              'Status': StatusChip(status: task.status),
                              'Progress': AppLinearProgress(
                                value: 0.65, // 65% progress
                              ),
                              'Created At': ProjectHelpers.formatDate(
                                project.createdAt,
                              ),
                              'Actions': Row(
                                children: [
                                  // 👁 View Details Button
                                  Tooltip(
                                    message: "View ${task.title}",
                                    child: AppButton(
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 8,
                                        horizontal: 4,
                                      ),
                                      backgroundColor: AppPalette.magnolia,
                                      borderRadius: 8,
                                      textstyle: AppTextStyles.bodyMedium
                                          .copyWith(
                                            color:
                                                palette
                                                    .AppPalette
                                                    .resolutionBlue,
                                          ),
                                      padding: const EdgeInsets.only(left: 8),
                                      prefixIcon: Icon(
                                        Icons.remove_red_eye_outlined,
                                        color: AppPalette.resolutionBlue,
                                        size: 18,
                                      ),
                                      text: '',
                                      onPressed:
                                          () => context.push(
                                            '/task-details/${task.id}',
                                          ),
                                    ),
                                  ),
                                  // 📝 Mark Complete / Update Status
                                  AppButton(
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 4,
                                    ),
                                    backgroundColor: AppPalette.magnolia,
                                    borderRadius: 8,
                                    textstyle: AppTextStyles.bodyMedium
                                        .copyWith(
                                          color:
                                              palette.AppPalette.resolutionBlue,
                                        ),
                                    padding: const EdgeInsets.only(left: 8),
                                    prefixIcon: Icon(
                                      Icons.check_circle_outline,
                                      color: Colors.green,
                                      size: 18,
                                    ),
                                    text: '',
                                    onPressed:
                                        () => _updateTaskStatus(
                                          task.id,
                                          'completed',
                                        ),
                                  ),

                                  // 🗑 Delete Button
                                  Tooltip(
                                    message: "Delete ${task.title}",
                                    child: AppButton(
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 8,
                                        horizontal: 4,
                                      ),
                                      backgroundColor: AppPalette.magnolia,
                                      borderRadius: 8,
                                      textstyle: AppTextStyles.bodyMedium
                                          .copyWith(
                                            color:
                                                palette
                                                    .AppPalette
                                                    .resolutionBlue,
                                          ),
                                      padding: const EdgeInsets.only(left: 8),
                                      prefixIcon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                        size: 18,
                                      ),
                                      text: '',
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder:
                                              (context) => AlertDialog(
                                                title: const Text(
                                                  "Delete Task",
                                                ),
                                                content: Text(
                                                  "Are you sure you want to delete '${task.title}'?",
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed:
                                                        () =>
                                                            Navigator.of(
                                                              context,
                                                            ).pop(),
                                                    child: const Text("Cancel"),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Provider.of<TaskNotifier>(
                                                        context,
                                                        listen: false,
                                                      ).removeTask(task.id);
                                                      Navigator.of(
                                                        context,
                                                      ).pop();
                                                    },
                                                    child: const Text(
                                                      "Delete",
                                                      style: TextStyle(
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            };
                          }).toList(),
                      onRowTap: (row) {
                        final tappedTask = filteredTasks.firstWhere(
                          (t) => t.title == row['Title'],
                        );
                        context.push('/task-details/${tappedTask.id}');
                      },
                    ),
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

class TaskHelpers {
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
