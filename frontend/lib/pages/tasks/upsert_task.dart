import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../model/task.dart';
import '../../notifiers/task_notifier.dart';
import '../../utils/components/app_button.dart';
import '../../utils/components/app_searchable_dropdowns.dart';
import '../../utils/components/app_textfield.dart';
import '../../utils/theme/app_palette.dart';
import '../../utils/theme/app_text_styles.dart';

class AddTaskPage extends StatefulWidget {
  final String projectId;

  const AddTaskPage({super.key, required this.projectId});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _status = 'todo';
  bool _isFormValid = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      _isFormValid =
          _titleController.text.isNotEmpty &&
          _descriptionController.text.isNotEmpty;
    });
  }

  void _submitForm() {
    if (_isFormValid) {
      final notifier = context.read<TaskNotifier>();
      final newTask = Task(
        id:
            UniqueKey()
                .toString(), // Simple ID generation; replace with UUID if needed
        projectId: widget.projectId,
        title: _titleController.text,
        description: _descriptionController.text,
        status: _status,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      notifier.addTask(newTask);
      Navigator.pop(context); // Return to TasksPage
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Add New Task'),
        actions: [
          AppButton(
            text: 'Save',
            margin: const EdgeInsets.all(8),
            backgroundColor: AppPalette.magnolia,
            borderRadius: 16,
            textstyle: AppTextStyles.bodyMedium.copyWith(
              color: AppPalette.resolutionBlue,
            ),
            prefixIcon: Icon(
              Icons.save_outlined,
              color: AppPalette.resolutionBlue,
              size: 18,
            ),
            onPressed: _isFormValid ? _submitForm : null, // Disable if invalid
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              AppTextField(
                label: 'Task Title',
                controller: _titleController,
                hint: 'Enter task title',
                onChanged: (_) => _validateForm(),
              ),
              const SizedBox(height: 16),
              AppTextField(
                label: 'Description',
                controller: _descriptionController,
                hint: 'Enter task description',
                onChanged: (_) => _validateForm(),
              ),
              const SizedBox(height: 16),
              AppSearchableDropdown<String>(
                items: ['todo', 'in_progress'],
                label: 'Initial Status',
                initialValue: 'todo',
                itemAsString: (status) => status,
                onChanged: (value) => setState(() => _status = value ?? 'todo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
