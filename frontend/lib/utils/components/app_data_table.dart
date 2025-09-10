import 'package:flutter/material.dart';

import '../theme/app_palette.dart';
import '../theme/app_text_styles.dart';

class CustomDataTable extends StatelessWidget {
  final List<String> columns;
  final List<Map<String, dynamic>> rows;
  final Function(Map<String, dynamic>)? onRowTap;

  const CustomDataTable({
    super.key,
    required this.columns,
    required this.rows,
    this.onRowTap,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns:
            columns
                .map(
                  (col) => DataColumn(
                    label: Text(col, style: AppTextStyles.headlineMedium),
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
                                Text(
                                  value.toString(),
                                  style: AppTextStyles.bodyLarge,
                                ),
                              ),
                            )
                            .toList(),
                    onSelectChanged:
                        onRowTap != null ? (selected) => onRowTap!(row) : null,
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
    );
  }
}

class StatusChip extends StatelessWidget {
  final String status;

  const StatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(status, style: AppTextStyles.displaySmall),
      backgroundColor: AppPalette.magnolia.withOpacity(0.2),
      labelStyle: AppTextStyles.bodyMedium.copyWith(color: AppPalette.magnolia),
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
