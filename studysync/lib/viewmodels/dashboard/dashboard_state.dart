import '../../models/task.dart';

class DashboardState {
  final List<Task> allTasks;
  final List<Task> upcomingTasks;
  final bool isLoading;
  final String? error;

  // Calculated stats
  late final int totalTasks = allTasks.length;
  late final int completedTasks = allTasks.where((t) => t.status == TaskStatus.completed).length;
  late final int pendingTasks = allTasks.where((t) => t.status == TaskStatus.pending).length;

  DashboardState({
    this.allTasks = const [],
    this.upcomingTasks = const [],
    this.isLoading = false,
    this.error,
  });

  /// Create initial state
  factory DashboardState.initial() {
    return DashboardState();
  }

  /// Copy with - for immutability
  DashboardState copyWith({
    List<Task>? allTasks,
    List<Task>? upcomingTasks,
    bool? isLoading,
    String? error,
  }) {
    return DashboardState(
      allTasks: allTasks ?? this.allTasks,
      upcomingTasks: upcomingTasks ?? this.upcomingTasks,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  String toString() => '''
DashboardState(
  totalTasks: $totalTasks,
  completedTasks: $completedTasks,
  pendingTasks: $pendingTasks,
  isLoading: $isLoading,
)''';
}