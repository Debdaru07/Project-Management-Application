import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../model/task.dart';
import '../../notifiers/task_notifier.dart';
import '../../utils/components/app_button.dart';
import '../../utils/components/app_data_table.dart';
import '../../utils/components/app_textfield.dart';
import '../../utils/theme/app_palette.dart';
import '../../utils/theme/app_text_styles.dart';

class TaskDetailsPage extends StatefulWidget {
  final String taskId;
  const TaskDetailsPage({super.key, required this.taskId});

  @override
  State<TaskDetailsPage> createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
  late TextEditingController _descController;
  bool _isEditingDesc = false;

  @override
  void initState() {
    super.initState();
    final task = Provider.of<TaskNotifier>(
      context,
      listen: false,
    ).tasks.firstWhere((t) => t.id == widget.taskId);
    _descController = TextEditingController(text: task.description);
  }

  @override
  void dispose() {
    _descController.dispose();
    super.dispose();
  }

  void _updateTask(Task task, {String? newStatus, String? newDescription}) {
    final notifier = context.read<TaskNotifier>();
    final updatedTask = Task(
      id: task.id,
      projectId: task.projectId,
      title: task.title,
      description: newDescription ?? task.description,
      status: newStatus ?? task.status,
      createdAt: task.createdAt,
      updatedAt: DateTime.now(),
    );
    notifier.updateTask(updatedTask);
    setState(() {
      _isEditingDesc = false;
    });
  }

  void _deleteTask(Task task) {
    final notifier = context.read<TaskNotifier>();
    notifier.removeTask(task.id);
    context.pop(); // go back after delete
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskNotifier>(
      builder: (context, notifier, child) {
        final task = notifier.tasks.firstWhere(
          (t) => t.id == widget.taskId,
          orElse: () => throw Exception("Task not found"),
        );

        return Scaffold(
          appBar: AppBar(
            title: Text(
              task.title,
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppPalette.raisinBlack,
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.pop(),
            ),
            actions: [
              DropdownButton<String>(
                value: task.status,
                items:
                    ["todo", "in_progress", "completed"]
                        .map(
                          (s) => DropdownMenuItem(
                            value: s,
                            child: StatusChip(status: s),
                          ),
                        )
                        .toList(),
                onChanged: (value) {
                  if (value != null) {
                    _updateTask(task, newStatus: value);
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder:
                        (context) => AlertDialog(
                          title: const Text("Delete Task"),
                          content: Text(
                            "Are you sure you want to delete '${task.title}'?",
                          ),
                          actions: [
                            AppButton(
                              onPressed: () => Navigator.of(context).pop(),
                              text: 'Cancel',
                            ),
                            TextButton(
                              onPressed: () {
                                _deleteTask(task);
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                "Delete",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                  );
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                // 📖 Description
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Description", style: AppTextStyles.bodyLarge),
                    IconButton(
                      icon: Icon(_isEditingDesc ? Icons.close : Icons.edit),
                      onPressed: () {
                        setState(() {
                          _isEditingDesc = !_isEditingDesc;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _isEditingDesc
                    ? Column(
                      children: [
                        AppTextField(
                          label: "Edit Description",
                          controller: _descController,
                        ),
                        const SizedBox(height: 12),
                        AppButton(
                          text: "Update",
                          onPressed:
                              () => _updateTask(
                                task,
                                newDescription: _descController.text,
                              ),
                        ),
                      ],
                    )
                    : Text(task.description),

                const SizedBox(height: 20),

                // 📅 Created At
                Text(
                  "Created At: ${task.createdAt.toLocal()}",
                  style: AppTextStyles.bodyMedium.copyWith(color: Colors.grey),
                ),
                Text(
                  "Last Updated: ${task.updatedAt.toLocal()}",
                  style: AppTextStyles.bodyMedium.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
