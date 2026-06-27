import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/spacing.dart';
import '../../providers/viewmodel_providers.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../../widgets/dashboard/stats_card.dart';
import '../../widgets/dashboard/upcoming_task_item.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final dashboardState = ref.watch(dashboardViewModelProvider);
    final viewModel = ref.read(dashboardViewModelProvider.notifier);

    if (dashboardState.error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(dashboardState.error!),
            backgroundColor: Colors.red,
          ),
        );
      });
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: 'StudySync',
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: _selectedIndex == 0
          ? _buildDashboard(context, dashboardState, viewModel)
          : _buildPlaceholder('Tasks'),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/addTask'),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task_outlined),
            activeIcon: Icon(Icons.task),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notes_outlined),
            activeIcon: Icon(Icons.notes),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildDashboard(BuildContext context, dashboardState, viewModel) {
    return dashboardState.isLoading
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            padding: AppSpacing.paddingMd,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back!',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    AppSpacing.gapVerticalSm,
                    Text(
                      'Here\'s your task overview',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                AppSpacing.gapVerticalLg,

                // Stats Cards - FIXED ✅
                GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 8,      // ← Reduced from 12
                  crossAxisSpacing: 8,     // ← Reduced from 12
                  childAspectRatio: 0.85,  // ← NEW: Controls height/width ratio
                  children: [
                    StatsCard(
                      title: 'Total',
                      value: dashboardState.totalTasks,
                      icon: Icons.task_alt,
                      backgroundColor: Colors.blue.withOpacity(0.1),
                      iconColor: Colors.blue,
                    ),
                    StatsCard(
                      title: 'Completed',
                      value: dashboardState.completedTasks,
                      icon: Icons.check_circle,
                      backgroundColor: Colors.green.withOpacity(0.1),
                      iconColor: Colors.green,
                    ),
                    StatsCard(
                      title: 'Pending',
                      value: dashboardState.pendingTasks,
                      icon: Icons.pending_actions,
                      backgroundColor: Colors.orange.withOpacity(0.1),
                      iconColor: Colors.orange,
                    ),
                  ],
                ),
                AppSpacing.gapVerticalLg,

                // Upcoming Deadlines
                Text(
                  'Upcoming Deadlines',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AppSpacing.gapVerticalMd,

                if (dashboardState.upcomingTasks.isEmpty)
                  Center(
                    child: Padding(
                      padding: AppSpacing.paddingLg,
                      child: Column(
                        children: [
                          Icon(
                            Icons.check_circle_outline,
                            size: 64,
                            color: Colors.grey[300],
                          ),
                          AppSpacing.gapVerticalMd,
                          Text(
                            'No upcoming tasks!',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            'You\'re all caught up',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: dashboardState.upcomingTasks.length,
                    separatorBuilder: (_, __) => AppSpacing.gapVerticalSm,
                    itemBuilder: (context, index) {
                      final task = dashboardState.upcomingTasks[index];
                      return UpcomingTaskItem(
                        task: task,
                        onComplete: () => viewModel.completeTask(task.id),
                        onTap: () {},
                      );
                    },
                  ),

                AppSpacing.gapVerticalLg,
              ],
            ),
          );
  }

  Widget _buildPlaceholder(String title) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.construction, size: 64, color: Colors.grey[300]),
          AppSpacing.gapVerticalMd,
          Text(
            '$title Screen',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          AppSpacing.gapVerticalSm,
          Text(
            'Coming soon',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}