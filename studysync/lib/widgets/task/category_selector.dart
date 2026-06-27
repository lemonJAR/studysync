import 'package:flutter/material.dart';
import '../../config/spacing.dart';
import '../../models/task.dart';
import '../../utils/color_utils.dart';

class CategorySelector extends StatelessWidget {
  final TaskCategory? selectedCategory;
  final Function(TaskCategory) onCategorySelected;
  final String? errorText;

  const CategorySelector({
    Key? key,
    required this.selectedCategory,
    required this.onCategorySelected,
    this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories = TaskCategory.values;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        AppSpacing.gapVerticalSm,
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: categories.map((category) {
            final isSelected = selectedCategory == category;
            final categoryName = category.toString().split('.').last.toUpperCase();
            final categoryColor = ColorUtils.getCategoryColor(category.toString());

            return GestureDetector(
              onTap: () => onCategorySelected(category),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? categoryColor : Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? categoryColor : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Text(
                  categoryName,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : Colors.grey[700],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        if (errorText != null)
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text(
              errorText!,
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}