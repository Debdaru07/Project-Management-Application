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
                textstyle: AppTextStyles.bodyMedium.copyWith(
                  color: palette.AppPalette.resolutionBlue,
                ),
                text: _isGridView ? 'Switch to Table' : 'Switch to Grid',
                onPressed: () => setState(() => _isGridView = !_isGridView),
              ),
              AppButton(
                margin: const EdgeInsets.all(8),
                backgroundColor: AppPalette.magnolia,
                borderRadius: 16,
                textstyle: AppTextStyles.bodyMedium.copyWith(
                  color: palette.AppPalette.resolutionBlue,
                ),
                text: 'Add Project',
                onPressed: () => context.push('/add-project'),
              ),
              const SizedBox(width: 12),
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

                              // status badge values
                              String label;
                              IconData icon;
                              Color color;
                              switch (project.status) {
                                case 'in_progress':
                                  label = 'In Progress';
                                  icon = Icons.autorenew;
                                  color = const Color(0xFF4F46E5); // Indigo 600
                                  break;
                                case 'to do':
                                  label = 'Todo';
                                  icon = Icons.edit_note;
                                  color = const Color(
                                    0xFF9CA3AF,
                                  ); // Neutral Gray 400
                                  break;
                                case 'completed':
                                  label = 'Completed';
                                  icon = Icons.check_circle;
                                  color = const Color(
                                    0xFF10B981,
                                  ); // Emerald 500
                                  break;
                                default:
                                  label = project.status;
                                  icon = Icons.help_outline;
                                  color = const Color(0xFF374151); // Gray 700
                              }

                              return InkWell(
                                onTap:
                                    () => context.push('/tasks/${project.id}'),
                                child: Card(
                                  color: Theme.of(context).colorScheme.surface,
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Project title
                                        Text(
                                          project.title,
                                          style: Theme.of(
                                            context,
                                          ).textTheme.titleMedium?.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),

                                        const SizedBox(height: 4),

                                        // Created at
                                        Text(
                                          "Created: ${project.createdAt}", // ensure createdAt is String or format DateTime
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodySmall?.copyWith(
                                            color: Theme.of(context).hintColor,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),

                                        const SizedBox(height: 8),

                                        // Description
                                        Expanded(
                                          child: Text(
                                            project.description,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(
                                              context,
                                            ).textTheme.bodyMedium?.copyWith(
                                              color:
                                                  Theme.of(context).hintColor,
                                            ),
                                          ),
                                        ),

                                        const SizedBox(height: 8),

                                        // Status badge
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Chip(
                                            avatar: Icon(
                                              icon,
                                              color: color,
                                              size: 16,
                                            ),
                                            label: Text(
                                              label,
                                              style: Theme.of(
                                                context,
                                              ).textTheme.bodySmall?.copyWith(
                                                color: color,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            backgroundColor: color.withOpacity(
                                              0.1,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              side: BorderSide(
                                                color: color.withOpacity(0.3),
                                                width: 0.5,
                                              ),
                                            ),
                                          ),
                                        ),
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
                                        '': Row(
                                          children: [
                                            AppButton(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 8,
                                                    horizontal: 4,
                                                  ),
                                              backgroundColor:
                                                  AppPalette.magnolia,
                                              borderRadius: 8,
                                              textstyle: AppTextStyles
                                                  .bodyMedium
                                                  .copyWith(
                                                    color:
                                                        palette
                                                            .AppPalette
                                                            .resolutionBlue,
                                                  ),
                                              padding: EdgeInsets.only(left: 8),
                                              prefixIcon: Icon(
                                                Icons.remove_red_eye_outlined,
                                                color:
                                                    AppPalette.resolutionBlue,
                                                size: 18,
                                              ),
                                              text: '',
                                              onPressed:
                                                  () => context.push(
                                                    '/tasks/${project.id}',
                                                  ),
                                            ),
                                            AppButton(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 8,
                                                    horizontal: 4,
                                                  ),
                                              backgroundColor:
                                                  AppPalette.magnolia,
                                              padding: EdgeInsets.only(left: 8),
                                              borderRadius: 8,
                                              textstyle: AppTextStyles
                                                  .bodyMedium
                                                  .copyWith(
                                                    color:
                                                        palette
                                                            .AppPalette
                                                            .resolutionBlue,
                                                  ),
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
                                                          "Delete Project",
                                                        ),
                                                        content: Text(
                                                          "Are you sure you want to delete '${project.title}'?",
                                                        ),
                                                        actions: [
                                                          TextButton(
                                                            onPressed:
                                                                () =>
                                                                    Navigator.of(
                                                                      context,
                                                                    ).pop(),
                                                            child: const Text(
                                                              "Cancel",
                                                            ),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              Provider.of<
                                                                ProjectNotifier
                                                              >(
                                                                context,
                                                                listen: false,
                                                              ).removeProject(
                                                                project.id,
                                                              );
                                                              Navigator.of(
                                                                context,
                                                              ).pop();
                                                            },
                                                            child: const Text(
                                                              "Delete",
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                );
                                              },
                                            ),
                                          ],
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
