import 'package:flutter/material.dart';
import '../../models/task.dart';

class TaskStatusBadge extends StatelessWidget {
  final TaskStatus status;

  const TaskStatusBadge({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isCompleted = status == TaskStatus.completed;
    final backgroundColor = isCompleted ? Colors.green : Colors.orange;
    final label = isCompleted ? 'Completed' : 'Pending';

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: backgroundColor,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}