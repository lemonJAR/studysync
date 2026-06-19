class AppConstants {
  // App Info
  static const String appName = 'StudySync';
  static const String appVersion = '1.0.0';

  // Timeouts
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration animationDuration = Duration(milliseconds: 300);

  // Task Categories
  static const List<String> taskCategories = [
    'Assignment',
    'Quiz',
    'Project',
    'Exam',
  ];

  // Task Status
  static const String statusPending = 'Pending';
  static const String statusCompleted = 'Completed';

  // Validation
  static const int minPasswordLength = 6;
  static const int maxNameLength = 50;
  static const int maxDescriptionLength = 500;

  // Storage Keys
  static const String userIdKey = 'userId';
  static const String userNameKey = 'userName';
  static const String userEmailKey = 'userEmail';
  static const String isLoggedInKey = 'isLoggedIn';
  static const String isDarkModeKey = 'isDarkMode';
  static const String notificationsEnabledKey = 'notificationsEnabled';

  // Routes
  static const String routeSplash = '/';
  static const String routeLogin = '/login';
  static const String routeSignUp = '/signup';
  static const String routeHome = '/home';
  static const String routeAddTask = '/add-task';
  static const String routeEditTask = '/edit-task';
  static const String routeProfile = '/profile';
  static const String routeNotes = '/notes';

  // Notifications
  static const int notificationIdTaskReminder = 1;
  static const int notificationIdNewTask = 2;

  // Messages
  static const String msgTaskAddedSuccess = 'Task added successfully';
  static const String msgTaskUpdatedSuccess = 'Task updated successfully';
  static const String msgTaskDeletedSuccess = 'Task deleted successfully';
  static const String msgProfileUpdatedSuccess = 'Profile updated successfully';
  static const String msgLoadingError = 'Failed to load data. Please try again.';
  static const String msgNetworkError = 'Network error. Check your connection.';
}
