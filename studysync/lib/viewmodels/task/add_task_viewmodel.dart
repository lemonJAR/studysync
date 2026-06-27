import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/task.dart';
import 'add_task_state.dart';

class AddTaskViewModel extends StateNotifier<AddTaskState> {
  AddTaskViewModel() : super(AddTaskState.initial());

  // Update methods
  void updateTitle(String title) {
    final error = _validateTitle(title);
    state = state.copyWith(title: title, titleError: error);
  }

  void updateDescription(String description) {
    final error = _validateDescription(description);
    state = state.copyWith(description: description, descriptionError: error);
  }

  void updateSubject(String subject) {
    final error = _validateSubject(subject);
    state = state.copyWith(subject: subject, subjectError: error);
  }

  void updateDueDate(DateTime dueDate) {
    final error = _validateDueDate(dueDate);
    state = state.copyWith(dueDate: dueDate, dueDateError: error);
  }

  void updateCategory(TaskCategory category) {
    state = state.copyWith(category: category);
  }

  // Validation methods
  String? _validateTitle(String title) {
    if (title.isEmpty) return 'Task title is required';
    if (title.length < 3) return 'Title must be at least 3 characters';
    if (title.length > 100) return 'Title must be less than 100 characters';
    return null;
  }

  String? _validateDescription(String description) {
    if (description.isEmpty) return 'Description is required';
    if (description.length < 5) return 'Description must be at least 5 characters';
    return null;
  }

  String? _validateSubject(String subject) {
    if (subject.isEmpty) return 'Subject is required';
    return null;
  }

  String? _validateDueDate(DateTime dueDate) {
    final now = DateTime.now();
    if (dueDate.isBefore(now)) {
      return 'Due date must be in the future';
    }
    return null;
  }

  /// Create task
  Future<void> createTask() async {
    // Validate all fields
    final titleError = _validateTitle(state.title);
    final descriptionError = _validateDescription(state.description);
    final subjectError = _validateSubject(state.subject);
    final dueDateError = state.dueDate == null ? 'Please select a due date' : _validateDueDate(state.dueDate!);
    final categoryError = state.category == null ? 'Please select a category' : null;

    // Update state with validation errors
    state = state.copyWith(
      titleError: titleError,
      descriptionError: descriptionError,
      subjectError: subjectError,
      dueDateError: dueDateError,
      categoryError: categoryError,
    );

    // Check if any validation errors
    if (titleError != null || 
        descriptionError != null || 
        subjectError != null || 
        dueDateError != null || 
        categoryError != null) {
      return;
    }

    // Set loading state
    state = state.copyWith(isLoading: true, error: null);

    try {
      // Simulate saving task to repository
      await Future.delayed(const Duration(seconds: 1));

      // Create task object
      final newTask = Task(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: state.title,
        description: state.description,
        subject: state.subject,
        dueDate: state.dueDate!,
        category: state.category!,
        status: TaskStatus.pending,
        createdAt: DateTime.now(),
      );

      // TODO: Save to repository when integrated
      print('Task created: $newTask');

      // Success
      state = state.copyWith(
        isLoading: false,
        successMessage: 'Task created successfully!',
      );
    } catch (e) {
      // Error
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to create task: $e',
      );
    }
  }

  /// Clear error message
  void clearError() {
    state = state.copyWith(error: null);
  }

  /// Reset form
  void reset() {
    state = AddTaskState.initial();
  }
}