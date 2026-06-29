import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/spacing.dart';
import '../../models/task.dart';
import '../../providers/viewmodel_providers.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../../widgets/dashboard/upcoming_task_item.dart';
import '../../widgets/search/filter_chips_widget.dart';
import '../../widgets/search/search_bar_widget.dart';
import '../../widgets/search/sort_dropdown_widget.dart';

class SearchFilterScreen extends ConsumerWidget {
  const SearchFilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchState = ref.watch(searchFilterViewModelProvider);
    final viewModel = ref.read(searchFilterViewModelProvider.notifier);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Search & Filter',
        showBackButton: true,
        onBackPressed: () => Navigator.pop(context),
      ),
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.paddingMd,
          child: Column(
            children: [
              // Search Bar
              SearchBarWidget(
                searchQuery: searchState.searchQuery,
                onSearchChanged: (query) =>
                    viewModel.updateSearchQuery(query),
                onClear: () => viewModel.clearSearch(),
              ),
              AppSpacing.gapVerticalLg,

              // Filters & Sort
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category Filter
                      FilterChipsWidget(
                        title: 'Category',
                        options: TaskCategory.values.toList(),
                        selectedOptions: searchState.selectedCategories,
                        onToggle: (category) =>
                            viewModel.toggleCategory(category),
                        isCategory: true,
                      ),
                      AppSpacing.gapVerticalLg,

                      // Status Filter
                      FilterChipsWidget(
                        title: 'Status',
                        options: TaskStatus.values.toList(),
                        selectedOptions: searchState.selectedStatuses,
                        onToggle: (status) =>
                            viewModel.toggleStatus(status),
                        isCategory: false,
                      ),
                      AppSpacing.gapVerticalLg,

                      // Sort Options
                      SortDropdownWidget(
                        currentSort: searchState.sortBy,
                        onSortChanged: (sort) =>
                            viewModel.updateSortBy(sort),
                      ),

                      // Clear Filters Button
                      if (searchState.hasActiveFilters)
                        Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: SizedBox(
                            width: double.infinity,
                            child: TextButton.icon(
                              onPressed: () => viewModel.clearAllFilters(),
                              icon: Icon(Icons.clear_all),
                              label: Text('Clear All Filters'),
                            ),
                          ),
                        ),

                      AppSpacing.gapVerticalLg,

                      // Results Header
                      Text(
                        'Results (${searchState.filteredTasks.length})',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      AppSpacing.gapVerticalMd,
                    ],
                  ),
                ),
              ),

              // Results List
              Expanded(
                flex: 2,
                child: searchState.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : searchState.filteredTasks.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.search_off,
                                    size: 64, color: Colors.grey[300]),
                                AppSpacing.gapVerticalMd,
                                Text(
                                  'No tasks found',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge,
                                ),
                                AppSpacing.gapVerticalSm,
                                Text(
                                  'Try adjusting your search or filters',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: Colors.grey),
                                ),
                              ],
                            ),
                          )
                        : ListView.separated(
                            itemCount: searchState.filteredTasks.length,
                            separatorBuilder: (_, __) =>
                                AppSpacing.gapVerticalSm,
                            itemBuilder: (context, index) {
                              final task = searchState.filteredTasks[index];
                              return UpcomingTaskItem(
                                task: task,
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/taskDetail',
                                    arguments: task,
                                  );
                                },
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}