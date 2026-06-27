import '../../models/task.dart';

class AddTaskState {
  final String title;
  final String description;
  final String subject;
  final DateTime? dueDate;
  final TaskCategory? category;
  final bool isLoading;
  final String? error;
  final String? successMessage;

  // Validation errors
  final String? titleError;
  final String? descriptionError;
  final String? subjectError;
  final String? dueDateError;
  final String? categoryError;

  AddTaskState({
    this.title = '',
    this.description = '',
    this.subject = '',
    this.dueDate,
    this.category,
    this.isLoading = false,
    this.error,
    this.successMessage,
    this.titleError,
    this.descriptionError,
    this.subjectError,
    this.dueDateError,
    this.categoryError,
  });

  /// Create initial state
  factory AddTaskState.initial() {
    return AddTaskState();
  }

  /// Copy with - for immutability
  AddTaskState copyWith({
    String? title,
    String? description,
    String? subject,
    DateTime? dueDate,
    TaskCategory? category,
    bool? isLoading,
    String? error,
    String? successMessage,
    String? titleError,
    String? descriptionError,
    String? subjectError,
    String? dueDateError,
    String? categoryError,
  }) {
    return AddTaskState(
      title: title ?? this.title,
      description: description ?? this.description,
      subject: subject ?? this.subject,
      dueDate: dueDate ?? this.dueDate,
      category: category ?? this.category,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      successMessage: successMessage ?? this.successMessage,
      titleError: titleError ?? this.titleError,
      descriptionError: descriptionError ?? this.descriptionError,
      subjectError: subjectError ?? this.subjectError,
      dueDateError: dueDateError ?? this.dueDateError,
      categoryError: categoryError ?? this.categoryError,
    );
  }

  @override
  String toString() => '''
AddTaskState(
  title: $title,
  subject: $subject,
  category: $category,
  dueDate: $dueDate,
  isLoading: $isLoading,
)''';
}