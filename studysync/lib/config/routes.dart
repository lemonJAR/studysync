import 'package:flutter/material.dart';
import '../screens/auth/sign_up_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/forgot_password_screen.dart';
import '../screens/main/dashboard_screen.dart';
import '../screens/task/add_task_screen.dart';
import '../screens/task/task_detail_screen.dart';
import '../models/task.dart';

class AppRoutes {
  static const String signup = '/signup';
  static const String login = '/login';
  static const String forgotPassword = '/forgotPassword';
  static const String home = '/home';
  static const String addTask = '/addTask';

  static Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case signup:
      return MaterialPageRoute(builder: (_) => const SignUpScreen());
    case login:
      return MaterialPageRoute(builder: (_) => const LoginScreen());
    case forgotPassword:
      return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
    case home:
      return MaterialPageRoute(builder: (_) => const DashboardScreen());
    case addTask:
      return MaterialPageRoute(builder: (_) => const AddTaskScreen());
    case '/taskDetail':
      if (settings.arguments is Task) {
        final task = settings.arguments as Task;
        return MaterialPageRoute(
          builder: (_) => TaskDetailScreen(task: task),
        );
      }
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(child: Text('Task not found')),
        ),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(child: Text('No route defined for ${settings.name}')),
        ),
      );
  }
}
}