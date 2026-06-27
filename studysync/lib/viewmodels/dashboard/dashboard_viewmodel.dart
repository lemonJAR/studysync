import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/task.dart';
import 'dashboard_state.dart';

class DashboardViewModel extends StateNotifier<DashboardState> {
  DashboardViewModel() : super(DashboardState.initial()) {
    loadTasks();
  }

  /// Load tasks from repository
  Future<void> loadTasks() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // Simulate loading tasks
      await Future.delayed(const Duration(seconds: 1));

      // Sample tasks for testing
      final sampleTasks = _generateSampleTasks();
      
      // Filter upcoming tasks (next 7 days)
      final now = DateTime.now();
      final sevenDaysFromNow = now.add(const Duration(days: 7));
      final upcoming = sampleTasks
          .where((t) => t.dueDate.isAfter(now) && t.dueDate.isBefore(sevenDaysFromNow))
          .toList()
        ..sort((a, b) => a.dueDate.compareTo(b.dueDate));

      state = state.copyWith(
        allTasks: sampleTasks,
        upcomingTasks: upcoming,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load tasks: $e',
      );
    }
  }

  /// Mark task as completed
  Future<void> completeTask(String taskId) async {
    try {
      final taskIndex = state.allTasks.indexWhere((t) => t.id == taskId);
      if (taskIndex != -1) {
        final updatedTask = state.allTasks[taskIndex].copyWith(
          status: TaskStatus.completed,
          completedAt: DateTime.now(),
        );

        final updatedTasks = [...state.allTasks];
        updatedTasks[taskIndex] = updatedTask;

        state = state.copyWith(allTasks: updatedTasks);
      }
    } catch (e) {
      state = state.copyWith(error: 'Failed to complete task: $e');
    }
  }

  /// Mark task as pending
  Future<void> pendingTask(String taskId) async {
    try {
      final taskIndex = state.allTasks.indexWhere((t) => t.id == taskId);
      if (taskIndex != -1) {
        final updatedTask = state.allTasks[taskIndex].copyWith(
          status: TaskStatus.pending,
          completedAt: null,
        );

        final updatedTasks = [...state.allTasks];
        updatedTasks[taskIndex] = updatedTask;

        state = state.copyWith(allTasks: updatedTasks);
      }
    } catch (e) {
      state = state.copyWith(error: 'Failed to update task: $e');
    }
  }

  /// Delete task
  Future<void> deleteTask(String taskId) async {
    try {
      final updatedTasks = state.allTasks.where((t) => t.id != taskId).toList();
      state = state.copyWith(allTasks: updatedTasks);
    } catch (e) {
      state = state.copyWith(error: 'Failed to delete task: $e');
    }
  }

  /// Generate sample tasks for demo
  List<Task> _generateSampleTasks() {
    final now = DateTime.now();
    return [
      Task(
        id: '1',
        title: 'Math Assignment Chapter 5',
        description: 'Complete exercises 1-20',
        subject: 'Mathematics',
        dueDate: now.add(const Duration(days: 2)),
        category: TaskCategory.assignment,
        status: TaskStatus.pending,
        createdAt: now,
      ),
      Task(
        id: '2',
        title: 'English Quiz',
        description: 'Literature Quiz on Shakespeare',
        subject: 'English',
        dueDate: now.add(const Duration(days: 1)),
        category: TaskCategory.quiz,
        status: TaskStatus.pending,
        createdAt: now,
      ),
      Task(
        id: '3',
        title: 'Science Project',
        description: 'Build a model of solar system',
        subject: 'Science',
        dueDate: now.add(const Duration(days: 5)),
        category: TaskCategory.project,
        status: TaskStatus.pending,
        createdAt: now,
      ),
      Task(
        id: '4',
        title: 'Physics Exam',
        description: 'Comprehensive exam covering chapters 1-10',
        subject: 'Physics',
        dueDate: now.add(const Duration(days: 10)),
        category: TaskCategory.exam,
        status: TaskStatus.pending,
        createdAt: now,
      ),
      Task(
        id: '5',
        title: 'History Essay',
        description: 'Write 2000-word essay on WWI',
        subject: 'History',
        dueDate: now.add(const Duration(days: 3)),
        category: TaskCategory.assignment,
        status: TaskStatus.completed,
        createdAt: now,
        completedAt: now.subtract(const Duration(days: 1)),
      ),
    ];
  }

  /// Clear error
  void clearError() {
    state = state.copyWith(error: null);
  }
}