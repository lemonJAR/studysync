import '../../models/task.dart';

class SearchFilterState {
  final String searchQuery;
  final Set<TaskCategory> selectedCategories;
  final Set<TaskStatus> selectedStatuses;
  final String sortBy; // 'date', 'title', 'status'
  final List<Task> filteredTasks;
  final bool isLoading;
  final String? error;

  SearchFilterState({
    this.searchQuery = '',
    this.selectedCategories = const {},
    this.selectedStatuses = const {},
    this.sortBy = 'date',
    this.filteredTasks = const [],
    this.isLoading = false,
    this.error,
  });

  /// Create initial state
  factory SearchFilterState.initial() {
    return SearchFilterState();
  }

  /// Copy with - for immutability
  SearchFilterState copyWith({
    String? searchQuery,
    Set<TaskCategory>? selectedCategories,
    Set<TaskStatus>? selectedStatuses,
    String? sortBy,
    List<Task>? filteredTasks,
    bool? isLoading,
    String? error,
  }) {
    return SearchFilterState(
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategories: selectedCategories ?? this.selectedCategories,
      selectedStatuses: selectedStatuses ?? this.selectedStatuses,
      sortBy: sortBy ?? this.sortBy,
      filteredTasks: filteredTasks ?? this.filteredTasks,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  /// Check if any filter is active
  bool get hasActiveFilters =>
      searchQuery.isNotEmpty ||
      selectedCategories.isNotEmpty ||
      selectedStatuses.isNotEmpty;

  @override
  String toString() => '''
SearchFilterState(
  searchQuery: $searchQuery,
  categories: ${selectedCategories.length},
  statuses: ${selectedStatuses.length},
  sortBy: $sortBy,
  results: ${filteredTasks.length},
)''';
}