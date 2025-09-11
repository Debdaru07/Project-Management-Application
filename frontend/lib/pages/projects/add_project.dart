import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../model/project.dart';
import '../../notifiers/project_notifier.dart';
import '../../utils/components/app_button.dart';
import '../../utils/components/app_searchable_dropdowns.dart';
import '../../utils/components/app_textfield.dart';
import '../../utils/theme/app_palette.dart';
import '../../utils/theme/app_text_styles.dart';

class AddProjectPage extends StatefulWidget {
  const AddProjectPage({super.key});

  @override
  State<AddProjectPage> createState() => _AddProjectPageState();
}

class _AddProjectPageState extends State<AddProjectPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _status = 'in_progress';
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _titleController.addListener(_validateForm);
    _descriptionController.addListener(_validateForm);
  }

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
      final notifier = context.read<ProjectNotifier>();
      var uuid = Uuid();
      final newProject = Project(
        id: uuid.v4(), // Simple ID generation; replace with UUID if needed
        title: _titleController.text,
        description: _descriptionController.text,
        status: _status,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      notifier.addProject(newProject);
      Navigator.pop(context); // Return to ProjectsPage
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Project'),
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
                label: 'Project Title',
                controller: _titleController,
                hint: 'Enter project title',
                onChanged: (_) => _validateForm(),
              ),
              const SizedBox(height: 16),
              AppTextField(
                label: 'Description',
                controller: _descriptionController,
                hint: 'Enter project description',
                onChanged: (_) => _validateForm(),
              ),
              const SizedBox(height: 16),
              AppSearchableDropdown<String>(
                items: ['in_progress', 'to do'],
                label: 'Status',
                initialValue: 'in_progress',
                itemAsString: (status) => status,
                onChanged:
                    (value) => setState(() => _status = value ?? 'in_progress'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
