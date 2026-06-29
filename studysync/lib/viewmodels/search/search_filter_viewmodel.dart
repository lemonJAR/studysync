import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/task.dart';
import 'search_filter_state.dart';

class SearchFilterViewModel extends StateNotifier<SearchFilterState> {
  final List<Task> allTasks;

  SearchFilterViewModel(this.allTasks) : super(SearchFilterState.initial()) {
    applyFilters();
  }

  /// Update search query
  void updateSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
    applyFilters();
  }

  /// Toggle category selection
  void toggleCategory(TaskCategory category) {
    final categories = Set<TaskCategory>.from(state.selectedCategories);
    if (categories.contains(category)) {
      categories.remove(category);
    } else {
      categories.add(category);
    }
    state = state.copyWith(selectedCategories: categories);
    applyFilters();
  }

  /// Toggle status selection
  void toggleStatus(TaskStatus status) {
    final statuses = Set<TaskStatus>.from(state.selectedStatuses);
    if (statuses.contains(status)) {
      statuses.remove(status);
    } else {
      statuses.add(status);
    }
    state = state.copyWith(selectedStatuses: statuses);
    applyFilters();
  }

  /// Update sort option
  void updateSortBy(String sortOption) {
    state = state.copyWith(sortBy: sortOption);
    applyFilters();
  }

  /// Apply all filters and search
  void applyFilters() {
    state = state.copyWith(isLoading: true, error: null);

    try {
      var filtered = List<Task>.from(allTasks);

      // Search filter
      if (state.searchQuery.isNotEmpty) {
        final query = state.searchQuery.toLowerCase();
        filtered = filtered.where((task) {
          return task.title.toLowerCase().contains(query) ||
              task.description.toLowerCase().contains(query) ||
              task.subject.toLowerCase().contains(query);
        }).toList();
      }

      // Category filter
      if (state.selectedCategories.isNotEmpty) {
        filtered = filtered
            .where((task) => state.selectedCategories.contains(task.category))
            .toList();
      }

      // Status filter
      if (state.selectedStatuses.isNotEmpty) {
        filtered = filtered
            .where((task) => state.selectedStatuses.contains(task.status))
            .toList();
      }

      // Apply sorting
      switch (state.sortBy) {
        case 'title':
          filtered.sort((a, b) => a.title.compareTo(b.title));
          break;
        case 'status':
          filtered.sort((a, b) => a.status.index.compareTo(b.status.index));
          break;
        case 'date':
        default:
          filtered.sort((a, b) => a.dueDate.compareTo(b.dueDate));
          break;
      }

      state = state.copyWith(
        filteredTasks: filtered,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to filter tasks: $e',
      );
    }
  }

  /// Clear all filters
  void clearAllFilters() {
    state = SearchFilterState.initial();
    applyFilters();
  }

  /// Clear search only
  void clearSearch() {
    state = state.copyWith(searchQuery: '');
    applyFilters();
  }

  /// Clear category filters
  void clearCategoryFilters() {
    state = state.copyWith(selectedCategories: {});
    applyFilters();
  }

  /// Clear status filters
  void clearStatusFilters() {
    state = state.copyWith(selectedStatuses: {});
    applyFilters();
  }
}