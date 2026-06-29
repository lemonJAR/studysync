import 'package:flutter/material.dart';
import '../../config/spacing.dart';

class SortDropdownWidget extends StatelessWidget {
  final String currentSort;
  final ValueChanged<String> onSortChanged;

  const SortDropdownWidget({
    Key? key,
    required this.currentSort,
    required this.onSortChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sort By',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        AppSpacing.gapVerticalSm,
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton<String>(
            isExpanded: true,
            underline: SizedBox(),
            value: currentSort,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            items: const [
              DropdownMenuItem(
                value: 'date',
                child: Row(
                  children: [
                    Icon(Icons.calendar_today, size: 18),
                    AppSpacing.gapHorizontalMd,
                    Text('Due Date (Upcoming)'),
                  ],
                ),
              ),
              DropdownMenuItem(
                value: 'title',
                child: Row(
                  children: [
                    Icon(Icons.sort_by_alpha, size: 18),
                    AppSpacing.gapHorizontalMd,
                    Text('Title (A-Z)'),
                  ],
                ),
              ),
              DropdownMenuItem(
                value: 'status',
                child: Row(
                  children: [
                    Icon(Icons.check_circle, size: 18),
                    AppSpacing.gapHorizontalMd,
                    Text('Status (Pending First)'),
                  ],
                ),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                onSortChanged(value);
              }
            },
          ),
        ),
      ],
    );
  }
}