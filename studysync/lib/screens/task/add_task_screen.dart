import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/spacing.dart';
import '../../models/task.dart';
import '../../providers/viewmodel_providers.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_text_field.dart';
import '../../widgets/task/category_selector.dart';
import '../../widgets/task/due_date_picker.dart';

class AddTaskScreen extends ConsumerWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addTaskState = ref.watch(addTaskViewModelProvider);
    final viewModel = ref.read(addTaskViewModelProvider.notifier);

    // Show error if any
    if (addTaskState.error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(addTaskState.error!),
            backgroundColor: Colors.red,
          ),
        );
      });
    }

    // Navigate on success
    if (addTaskState.successMessage != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(addTaskState.successMessage!),
            backgroundColor: Colors.green,
          ),
        );
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pop(context);
        });
      });
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Add Task',
        showBackButton: true,
        onBackPressed: () => Navigator.pop(context),
      ),
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.paddingMd,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSpacing.gapVerticalMd,

                // Title
                Text(
                  'Create New Task',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AppSpacing.gapVerticalSm,

                // Subtitle
                Text(
                  'Add a new task to your study plan',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
                ),
                AppSpacing.gapVerticalLg,

                // Task Title
                CustomTextField(
                  label: 'Task Title',
                  hint: 'Enter task title',
                  prefixIcon: Icons.title,
                  errorText: addTaskState.titleError,
                  onChanged: (value) {
                    viewModel.updateTitle(value);
                  },
                ),
                AppSpacing.gapVerticalLg,

                // Subject
                CustomTextField(
                  label: 'Subject',
                  hint: 'e.g., Mathematics, English, Science',
                  prefixIcon: Icons.book_outlined,
                  errorText: addTaskState.subjectError,
                  onChanged: (value) {
                    viewModel.updateSubject(value);
                  },
                ),
                AppSpacing.gapVerticalLg,

                // Description
                CustomTextField(
                  label: 'Description',
                  hint: 'Enter task description',
                  prefixIcon: Icons.description_outlined,
                  errorText: addTaskState.descriptionError,
                  maxLines: 3,
                  onChanged: (value) {
                    viewModel.updateDescription(value);
                  },
                ),
                AppSpacing.gapVerticalLg,

                // Category Selector
                CategorySelector(
                  selectedCategory: addTaskState.category,
                  onCategorySelected: (category) {
                    viewModel.updateCategory(category);
                  },
                  errorText: addTaskState.categoryError,
                ),
                AppSpacing.gapVerticalLg,

                // Due Date Picker
                DueDatePicker(
                  selectedDate: addTaskState.dueDate,
                  onDateSelected: (date) {
                    viewModel.updateDueDate(date);
                  },
                  errorText: addTaskState.dueDateError,
                ),
                AppSpacing.gapVerticalLg,

                // Create Button
                PrimaryButton(
                  label: 'Create Task',
                  isLoading: addTaskState.isLoading,
                  isEnabled: !addTaskState.isLoading,
                  onPressed: () => viewModel.createTask(),
                ),
                AppSpacing.gapVerticalMd,

                // Cancel Button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                ),
                AppSpacing.gapVerticalXl,
              ],
            ),
          ),
        ),
      ),
    );
  }
}