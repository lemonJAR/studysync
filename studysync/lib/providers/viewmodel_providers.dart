import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/auth/sign_up_viewmodel.dart';
import '../viewmodels/auth/sign_up_state.dart';
import '../viewmodels/auth/login_viewmodel.dart';
import '../viewmodels/auth/login_state.dart';
import '../viewmodels/auth/forgot_password_viewmodel.dart';
import '../viewmodels/auth/forgot_password_state.dart';
import 'service_providers.dart';

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
