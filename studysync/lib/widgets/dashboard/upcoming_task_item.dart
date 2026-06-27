import 'package:flutter/material.dart';
import '../../config/spacing.dart';
import '../../models/task.dart';
import '../../utils/color_utils.dart';

class UpcomingTaskItem extends StatelessWidget {
  final Task task;
  final VoidCallback? onTap;
  final VoidCallback? onComplete;

  const UpcomingTaskItem({
    Key? key,
    required this.task,
    this.onTap,
    this.onComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final daysUntil = task.daysUntilDue;
    final isOverdue = task.isOverdue;

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        leading: Checkbox(
          value: task.status == TaskStatus.completed,
          onChanged: (_) => onComplete?.call(),
        ),
        title: Text(
          task.title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            decoration: task.status == TaskStatus.completed
                ? TextDecoration.lineThrough
                : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSpacing.gapVerticalXs,
            Text(
              task.subject,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            AppSpacing.gapVerticalXs,
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: ColorUtils.getCategoryColor(task.category.toString()).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    task.category.toString().split('.').last.toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: ColorUtils.getCategoryColor(task.category.toString()),
                    ),
                  ),
                ),
                AppSpacing.gapHorizontalMd,
                Text(
                  isOverdue ? 'OVERDUE' : daysUntil == 0 ? 'TODAY' : 'In $daysUntil days',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isOverdue ? Colors.red : Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}