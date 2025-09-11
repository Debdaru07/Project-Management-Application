import 'package:flutter/material.dart';

import '../theme/app_palette.dart';
import '../theme/app_text_styles.dart';

class AppDataTable extends StatelessWidget {
  final List<String> columns;
  final List<Map<String, dynamic>> rows;
  final Function(Map<String, dynamic>)? onRowTap;

  const AppDataTable({
    super.key,
    required this.columns,
    required this.rows,
    this.onRowTap,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.95,
        child: DataTable(
          showCheckboxColumn: false,
          columns:
              columns
                  .map(
                    (col) => DataColumn(
                      label: Text(
                        col,
                        style: AppTextStyles.headlineMedium.copyWith(
                          color: AppPalette.primarySwatch,
                        ),
                      ),
                    ),
                  )
                  .toList(),
          rows:
              rows
                  .map(
                    (row) => DataRow(
                      cells:
                          row.values
                              .map(
                                (value) => DataCell(
                                  value is Widget
                                      ? value
                                      : Text(
                                        value.toString(),
                                        style: AppTextStyles.bodyLarge,
                                      ),
                                ),
                              )
                              .toList(),
                      onSelectChanged:
                          onRowTap != null
                              ? (selected) => onRowTap!(row)
                              : null,
                    ),
                  )
                  .toList(),
          headingRowColor: WidgetStatePropertyAll(
            AppPalette.magnolia.withOpacity(0.1),
          ),
          dataRowColor: WidgetStatePropertyAll(Colors.white),
          decoration: BoxDecoration(
            border: Border.all(color: AppPalette.raisinBlack.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}

class StatusChip extends StatelessWidget {
  final String status;

  const StatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    late final String label;
    late final IconData icon;
    late final Color color;

    switch (status) {
      case 'in_progress':
        label = 'In Progress';
        icon = Icons.autorenew;
        color = const Color(0xFF4F46E5); // Indigo 600
        break;
      case 'to do':
        label = 'Todo';
        icon = Icons.edit_note;
        color = const Color(0xFF9CA3AF); // Neutral Gray 400
        break;
      case 'completed':
        label = 'Completed';
        icon = Icons.check_circle;
        color = const Color(0xFF10B981); // Emerald 500
        break;
      default:
        label = status;
        icon = Icons.help_outline;
        color = const Color(0xFF374151); // Gray 700
    }

    return Chip(
      avatar: Icon(icon, color: AppPalette.magnolia, size: 18),
      label: Text(
        label,
        style: AppTextStyles.bodyMedium.copyWith(color: AppPalette.magnolia),
      ),
      backgroundColor: color,
      shape: StadiumBorder(side: BorderSide(color: color, width: 0)),
    );
  }
}

class Timeline extends StatelessWidget {
  final List<Map<String, String>>
  events; // e.g., {'title': 'Case Filed', 'date': '2025-08-01'}

  const Timeline({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          events.asMap().entries.map((entry) {
            final index = entry.key;
            final event = entry.value;
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: AppPalette.magnolia,
                child: Text(
                  '${index + 1}',
                  style: AppTextStyles.displayMedium.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
              title: Text(
                event['title'] ?? '',
                style: AppTextStyles.displayMedium,
              ),
              subtitle: Text(
                event['date'] ?? '',
                style: AppTextStyles.displayMedium,
              ),
            );
          }).toList(),
    );
  }
}

class ExpandableListItem extends StatelessWidget {
  final String title;
  final Widget expandedContent;
  final bool isExpanded;

  const ExpandableListItem({
    super.key,
    required this.title,
    required this.expandedContent,
    this.isExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(title, style: AppTextStyles.headlineMedium),
      initiallyExpanded: isExpanded,
      children: [Padding(padding: EdgeInsets.all(6), child: expandedContent)],
    );
  }
}
