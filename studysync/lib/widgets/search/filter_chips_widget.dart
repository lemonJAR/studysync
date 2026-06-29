import 'package:flutter/material.dart';
import '../../config/spacing.dart';
import '../../models/task.dart';
import '../../utils/color_utils.dart';

class FilterChipsWidget extends StatelessWidget {
  final String title;
  final List<dynamic> options;
  final Set<dynamic> selectedOptions;
  final Function(dynamic) onToggle;
  final bool isCategory;

  const FilterChipsWidget({
    Key? key,
    required this.title,
    required this.options,
    required this.selectedOptions,
    required this.onToggle,
    this.isCategory = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        AppSpacing.gapVerticalSm,
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((option) {
            final isSelected = selectedOptions.contains(option);
            final label = isCategory
                ? option.toString().split('.').last.toUpperCase()
                : option.toString().split('.').last;
            
            final color = isCategory
                ? ColorUtils.getCategoryColor(option.toString())
                : (option == TaskStatus.completed ? Colors.green : Colors.orange);

            return FilterChip(
              label: Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : Colors.black87,
                ),
              ),
              backgroundColor: isSelected ? color : Colors.grey[200],
              selectedColor: color,
              onSelected: (_) => onToggle(option),
              selected: isSelected,
            );
          }).toList(),
        ),
      ],
    );
  }
}