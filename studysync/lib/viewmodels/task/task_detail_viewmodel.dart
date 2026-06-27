import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/task.dart';
import 'task_detail_state.dart';

class TaskDetailViewModel extends StateNotifier<TaskDetailState> {
  TaskDetailViewModel(Task task) : super(TaskDetailState.fromTask(task)) {
    _initializeEditFields();
  }

  /// Initialize edit fields from task
  void _initializeEditFields() {
    if (state.task != null) {
      state = state.copyWith(
        editTitle: state.task!.title,
        editDescription: state.task!.description,
        editSubject: state.task!.subject,
        editDueDate: state.task!.dueDate,
        editCategory: state.task!.category,
      );
    }
  }

  /// Toggle edit mode
  void toggleEditMode() {
    state = state.copyWith(isEditing: !state.isEditing);
  }

  /// Update edit title
  void updateEditTitle(String title) {
    state = state.copyWith(editTitle: title);
  }

  /// Update edit description
  void updateEditDescription(String description) {
    state = state.copyWith(editDescription: description);
  }

  /// Update edit subject
  void updateEditSubject(String subject) {
    state = state.copyWith(editSubject: subject);
  }

  /// Update edit due date
  void updateEditDueDate(DateTime dueDate) {
    state = state.copyWith(editDueDate: dueDate);
  }

  /// Update edit category
  void updateEditCategory(TaskCategory category) {
    state = state.copyWith(editCategory: category);
  }

  /// Save edited task
  Future<void> saveTask() async {
    if (state.task == null) return;

    // Validate
    if ((state.editTitle?.isEmpty ?? true) ||
        (state.editDescription?.isEmpty ?? true) ||
        (state.editSubject?.isEmpty ?? true) ||
        state.editDueDate == null ||
        state.editCategory == null) {
      state = state.copyWith(error: 'Please fill all fields');
      return;
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      await Future.delayed(const Duration(seconds: 1));

      // Update task
      final updatedTask = state.task!.copyWith(
        title: state.editTitle,
        description: state.editDescription,
        subject: state.editSubject,
        dueDate: state.editDueDate,
        category: state.editCategory,
      );

      state = state.copyWith(
        task: updatedTask,
        isLoading: false,
        isEditing: false,
        successMessage: 'Task updated successfully!',
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to update task: $e',
      );
    }
  }

  /// Mark task as complete
  Future<void> completeTask() async {
    if (state.task == null) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      await Future.delayed(const Duration(milliseconds: 500));

      final completedTask = state.task!.copyWith(
        status: TaskStatus.completed,
        completedAt: DateTime.now(),
      );

      state = state.copyWith(
        task: completedTask,
        isLoading: false,
        successMessage: 'Task marked as completed!',
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to complete task: $e',
      );
    }
  }

  /// Mark task as pending
  Future<void> pendingTask() async {
    if (state.task == null) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      await Future.delayed(const Duration(milliseconds: 500));

      final pendingTask = state.task!.copyWith(
        status: TaskStatus.pending,
        completedAt: null,
      );

      state = state.copyWith(
        task: pendingTask,
        isLoading: false,
        successMessage: 'Task marked as pending!',
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to update task: $e',
      );
    }
  }

  /// Delete task
  Future<void> deleteTask() async {
    if (state.task == null) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      await Future.delayed(const Duration(seconds: 1));

      // Task will be deleted
      state = state.copyWith(
        isLoading: false,
        successMessage: 'Task deleted successfully!',
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to delete task: $e',
      );
    }
  }

  /// Clear error
  void clearError() {
    state = state.copyWith(error: null);
  }

  /// Clear success message
  void clearSuccess() {
    state = state.copyWith(successMessage: null);
  }
}