import '../../models/task.dart';

class TaskDetailState {
  final Task? task;
  final bool isLoading;
  final bool isEditing;
  final String? error;
  final String? successMessage;

  // Edit fields
  final String? editTitle;
  final String? editDescription;
  final String? editSubject;
  final DateTime? editDueDate;
  final TaskCategory? editCategory;

  TaskDetailState({
    this.task,
    this.isLoading = false,
    this.isEditing = false,
    this.error,
    this.successMessage,
    this.editTitle,
    this.editDescription,
    this.editSubject,
    this.editDueDate,
    this.editCategory,
  });

  /// Create initial state
  factory TaskDetailState.initial() {
    return TaskDetailState();
  }

  /// Create from task (for viewing)
  factory TaskDetailState.fromTask(Task task) {
    return TaskDetailState(task: task);
  }

  /// Copy with - for immutability
  TaskDetailState copyWith({
    Task? task,
    bool? isLoading,
    bool? isEditing,
    String? error,
    String? successMessage,
    String? editTitle,
    String? editDescription,
    String? editSubject,
    DateTime? editDueDate,
    TaskCategory? editCategory,
  }) {
    return TaskDetailState(
      task: task ?? this.task,
      isLoading: isLoading ?? this.isLoading,
      isEditing: isEditing ?? this.isEditing,
      error: error ?? this.error,
      successMessage: successMessage ?? this.successMessage,
      editTitle: editTitle ?? this.editTitle,
      editDescription: editDescription ?? this.editDescription,
      editSubject: editSubject ?? this.editSubject,
      editDueDate: editDueDate ?? this.editDueDate,
      editCategory: editCategory ?? this.editCategory,
    );
  }

  @override
  String toString() => '''
TaskDetailState(
  task: ${task?.title},
  isLoading: $isLoading,
  isEditing: $isEditing,
)''';
}