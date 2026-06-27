import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../config/spacing.dart';
import '../../models/task.dart';
import '../../providers/viewmodel_providers.dart';
import '../../viewmodels/task/task_detail_state.dart';
import '../../viewmodels/task/task_detail_viewmodel.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_text_field.dart';
import '../../widgets/task/category_selector.dart';
import '../../widgets/task/due_date_picker.dart';
import '../../widgets/task/task_detail_item.dart';
import '../../widgets/task/task_status_badge.dart';
import '../../utils/color_utils.dart';

class TaskDetailScreen extends ConsumerWidget {
  final Task task;

  const TaskDetailScreen({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailState = ref.watch(taskDetailViewModelProvider(task));
    final viewModel = ref.read(taskDetailViewModelProvider(task).notifier);

    // Show error
    if (detailState.error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(detailState.error!),
            backgroundColor: Colors.red,
          ),
        );
        viewModel.clearError();
      });
    }

    // Show success
    if (detailState.successMessage != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(detailState.successMessage!),
            backgroundColor: Colors.green,
          ),
        );
        viewModel.clearSuccess();
        
        // Navigate back after delete
        if (detailState.successMessage!.contains('deleted')) {
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.pop(context);
          });
        }
      });
    }

    if (detailState.task == null) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final currentTask = detailState.task!;

    return Scaffold(
      appBar: CustomAppBar(
        title: detailState.isEditing ? 'Edit Task' : 'Task Details',
        showBackButton: true,
        onBackPressed: () {
          if (detailState.isEditing) {
            viewModel.toggleEditMode();
          } else {
            Navigator.pop(context);
          }
        },
        actions: [
          if (!detailState.isEditing)
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text('Edit'),
                  value: 'edit',
                ),
                PopupMenuItem(
                  child: Text('Delete', style: TextStyle(color: Colors.red)),
                  value: 'delete',
                ),
              ],
              onSelected: (value) {
                if (value == 'edit') {
                  viewModel.toggleEditMode();
                } else if (value == 'delete') {
                  _showDeleteDialog(context, viewModel);
                }
              },
            ),
        ],
      ),
      body: detailState.isEditing
          ? _buildEditMode(context, detailState, viewModel)
          : _buildViewMode(context, currentTask, detailState, viewModel),
    );
  }

  Widget _buildViewMode(BuildContext context, Task task, TaskDetailState state, TaskDetailViewModel viewModel) {
    return SingleChildScrollView(
      padding: AppSpacing.paddingMd,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSpacing.gapVerticalMd,

          // Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TaskStatusBadge(status: task.status),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: ColorUtils.getCategoryColor(task.category.toString()).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  task.category.toString().split('.').last.toUpperCase(),
                  style: TextStyle(
                    color: ColorUtils.getCategoryColor(task.category.toString()),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          AppSpacing.gapVerticalLg,

          // Title
          Text(
            task.title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          AppSpacing.gapVerticalMd,

          // Description
          Container(
            padding: AppSpacing.paddingMd,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              task.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          AppSpacing.gapVerticalLg,

          // Details
          Text(
            'Details',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          AppSpacing.gapVerticalMd,

          TaskDetailItem(
            label: 'Subject',
            value: task.subject,
            icon: Icons.book_outlined,
          ),
          TaskDetailItem(
            label: 'Due Date',
            value: DateFormat('MMM dd, yyyy').format(task.dueDate),
            icon: Icons.calendar_today,
          ),
          TaskDetailItem(
            label: 'Days Until Due',
            value: task.daysUntilDue > 0 ? 'In ${task.daysUntilDue} days' : 'Today',
            icon: Icons.schedule,
          ),
          TaskDetailItem(
            label: 'Created',
            value: DateFormat('MMM dd, yyyy').format(task.createdAt),
            icon: Icons.add_circle_outline,
          ),
          if (task.status == TaskStatus.completed && task.completedAt != null)
            TaskDetailItem(
              label: 'Completed',
              value: DateFormat('MMM dd, yyyy').format(task.completedAt!),
              icon: Icons.check_circle,
            ),

          AppSpacing.gapVerticalLg,

          // Action Buttons
          if (task.status == TaskStatus.pending)
            PrimaryButton(
              label: 'Mark as Complete',
              onPressed: () => viewModel.completeTask(),
            )
          else
            PrimaryButton(
              label: 'Mark as Pending',
              onPressed: () => viewModel.pendingTask(),
            ),

          AppSpacing.gapVerticalXl,
        ],
      ),
    );
  }

  Widget _buildEditMode(BuildContext context, TaskDetailState state, TaskDetailViewModel viewModel) {
    // Create controllers with initial values
    final titleController = TextEditingController(text: state.editTitle);
    final subjectController = TextEditingController(text: state.editSubject);
    final descriptionController = TextEditingController(text: state.editDescription);

    return SingleChildScrollView(
      padding: AppSpacing.paddingMd,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSpacing.gapVerticalMd,

          // Title
          Text(
            'Edit Task',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          AppSpacing.gapVerticalLg,

          // Task Title
          CustomTextField(
            label: 'Task Title',
            hint: 'Enter task title',
            prefixIcon: Icons.title,
            controller: titleController,
            onChanged: (value) {
              viewModel.updateEditTitle(value);
            },
          ),
          AppSpacing.gapVerticalLg,

          // Subject
          CustomTextField(
            label: 'Subject',
            hint: 'e.g., Mathematics, English',
            prefixIcon: Icons.book_outlined,
            controller: subjectController,
            onChanged: (value) {
              viewModel.updateEditSubject(value);
            },
          ),
          AppSpacing.gapVerticalLg,

          // Description
          CustomTextField(
            label: 'Description',
            hint: 'Enter task description',
            prefixIcon: Icons.description_outlined,
            controller: descriptionController,
            maxLines: 3,
            onChanged: (value) {
              viewModel.updateEditDescription(value);
            },
          ),
          AppSpacing.gapVerticalLg,

          // Category
          CategorySelector(
            selectedCategory: state.editCategory,
            onCategorySelected: (category) => viewModel.updateEditCategory(category),
          ),
          AppSpacing.gapVerticalLg,

          // Due Date
          DueDatePicker(
            selectedDate: state.editDueDate,
            onDateSelected: (date) => viewModel.updateEditDueDate(date),
          ),
          AppSpacing.gapVerticalLg,

          // Save Button
          PrimaryButton(
            label: 'Save Changes',
            isLoading: state.isLoading,
            isEnabled: !state.isLoading,
            onPressed: () => viewModel.saveTask(),
          ),
          AppSpacing.gapVerticalMd,

          // Cancel Button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => viewModel.toggleEditMode(),
              child: const Text('Cancel'),
            ),
          ),
          AppSpacing.gapVerticalXl,
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, TaskDetailViewModel viewModel) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Task?'),
        content: Text('This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              viewModel.deleteTask();
            },
            child: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}