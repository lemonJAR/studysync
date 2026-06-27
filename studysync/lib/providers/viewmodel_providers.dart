import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task.dart';
import '../viewmodels/auth/sign_up_viewmodel.dart';
import '../viewmodels/auth/sign_up_state.dart';
import '../viewmodels/auth/login_viewmodel.dart';
import '../viewmodels/auth/login_state.dart';
import '../viewmodels/auth/forgot_password_viewmodel.dart';
import '../viewmodels/auth/forgot_password_state.dart';
import '../viewmodels/dashboard/dashboard_viewmodel.dart';
import '../viewmodels/dashboard/dashboard_state.dart';
import 'service_providers.dart';
import '../viewmodels/task/add_task_viewmodel.dart';
import '../viewmodels/task/add_task_state.dart';
import '../viewmodels/task/task_detail_viewmodel.dart';
import '../viewmodels/task/task_detail_state.dart';

/// Sign Up ViewModel Provider
final signUpViewModelProvider = StateNotifierProvider<SignUpViewModel, SignUpState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return SignUpViewModel(authRepository);
});

/// Login ViewModel Provider
final loginViewModelProvider = StateNotifierProvider<LoginViewModel, LoginState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return LoginViewModel(authRepository);
});

/// Forgot Password ViewModel Provider
final forgotPasswordViewModelProvider = StateNotifierProvider<ForgotPasswordViewModel, ForgotPasswordState>((ref) {
  return ForgotPasswordViewModel();
});

/// Dashboard ViewModel Provider
final dashboardViewModelProvider = StateNotifierProvider<DashboardViewModel, DashboardState>((ref) {
  return DashboardViewModel();
});

/// Add Task ViewModel Provider
final addTaskViewModelProvider = StateNotifierProvider<AddTaskViewModel, AddTaskState>((ref) {
  return AddTaskViewModel();
});

/// Task Detail ViewModel Provider
final taskDetailViewModelProvider = StateNotifierProvider.family<
    TaskDetailViewModel,
    TaskDetailState,
    Task>((ref, task) {
  return TaskDetailViewModel(task);
});