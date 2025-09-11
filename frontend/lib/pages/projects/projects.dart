import 'dart:developer' as console;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../model/project.dart';
import '../../notifiers/project_notifier.dart';
import '../../utils/components/app_button.dart';
import '../../utils/components/app_data_table.dart';
import '../../utils/components/app_searchable_dropdowns.dart';
import '../../utils/components/app_textfield.dart';
import '../../utils/features/project_helper.dart';
import '../../utils/theme/app_palette.dart';
import '../../utils/theme/app_palette.dart' as palette;
import '../../utils/theme/app_text_styles.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  bool _isGridView = false;
  final TextEditingController _searchController = TextEditingController();
  String _selectedStatus = 'all';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProjectNotifier>(
      builder: (context, notifier, child) {
        final filteredProjects = ProjectHelpers.filterProjects(
          notifier.projects,
          _searchController.text,
          _selectedStatus,
        );
        for (Project item in filteredProjects) {
          console.log('Filtered Projects: ${item.toJson()}');
        }
        return Scaffold(
          backgroundColor: AppPalette.magnolia,
          appBar: AppBar(
            title: const Text('Projects'),
            actions: [
              AppButton(
                margin: const EdgeInsets.all(8),
                backgroundColor: AppPalette.magnolia,
                borderRadius: 16,
                textstyle: AppTextStyles.bodyLarge.copyWith(
                  color: palette.AppPalette.raisinBlack,
                ),
                text: _isGridView ? 'Switch to Table' : 'Switch to Grid',
                onPressed: () => setState(() => _isGridView = !_isGridView),
              ),
              const SizedBox(width: 10),
              AppButton(
                margin: const EdgeInsets.all(8),
                backgroundColor: AppPalette.magnolia,
                borderRadius: 16,
                textstyle: AppTextStyles.bodyLarge.copyWith(
                  color: palette.AppPalette.raisinBlack,
                ),
                text: 'Add Project',
                onPressed: () => context.push('/add-project'),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        label: 'Search Projects',
                        controller: _searchController,
                        hint: 'Enter project title...',
                        onChanged: (_) => setState(() {}),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: AppSearchableDropdown<String>(
                        items: ['all', 'in_progress', 'completed'],
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
                  child:
                      _isGridView
                          ? GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 1.5,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                            itemCount: filteredProjects.length,
                            itemBuilder: (context, index) {
                              final project = filteredProjects[index];
                              return InkWell(
                                onTap:
                                    () => context.push('/tasks/${project.id}'),
                                child: Card(
                                  color: Theme.of(context).colorScheme.surface,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          project.title,
                                          style:
                                              Theme.of(
                                                context,
                                              ).textTheme.titleLarge,
                                        ),
                                        Text(
                                          project.description,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text('Status: ${project.status}'),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                          : AppDataTable(
                            columns: const [
                              'Title',
                              'Description',
                              'Status',
                              'Created At',
                              'Actions',
                            ],
                            rows:
                                filteredProjects
                                    .map(
                                      (project) => {
                                        'Title': project.title,
                                        'Description': project.description,
                                        'Status': StatusChip(
                                          status: project.status,
                                        ),
                                        'Created At': ProjectHelpers.formatDate(
                                          project.createdAt,
                                        ),
                                        '': AppButton(
                                          margin: const EdgeInsets.all(8),
                                          backgroundColor: AppPalette.magnolia,
                                          borderRadius: 16,
                                          text: 'View Tasks',
                                          prefixIcon: Icon(
                                            Icons.remove_red_eye_outlined,
                                            size: 18,
                                            color: AppPalette.primarySwatch,
                                          ),
                                          textstyle: AppTextStyles.bodyLarge
                                              .copyWith(
                                                color:
                                                    palette
                                                        .AppPalette
                                                        .raisinBlack,
                                              ),
                                          onPressed:
                                              () => context.push(
                                                '/tasks/${project.id}',
                                              ),
                                        ),
                                      },
                                    )
                                    .toList(),
                            onRowTap:
                                (row) => context.push(
                                  '/tasks/${filteredProjects[filteredProjects.indexWhere((p) => p.title == row['Title'])].id}',
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
