import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../repositories/auth_repository.dart';
import 'login_state.dart';

class LoginViewModel extends StateNotifier<LoginState> {
  final AuthRepository _authRepository;

  LoginViewModel(this._authRepository) : super(LoginState.initial());

  // Update methods
  void updateEmail(String email) {
    final error = _validateEmail(email);
    state = state.copyWith(email: email, emailError: error);
  }

  void updatePassword(String password) {
    final error = _validatePassword(password);
    state = state.copyWith(password: password, passwordError: error);
  }

  void updateRememberMe(bool value) {
    state = state.copyWith(rememberMe: value);
  }

  // Validation methods
  String? _validateEmail(String email) {
    if (email.isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    if (!emailRegex.hasMatch(email)) return 'Please enter a valid email';
    return null;
  }

  String? _validatePassword(String password) {
    if (password.isEmpty) return 'Password is required';
    if (password.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  /// Main login method
  Future<void> login() async {
    // Validate all fields first
    final emailError = _validateEmail(state.email);
    final passwordError = _validatePassword(state.password);

    // Update state with validation errors
    state = state.copyWith(
      emailError: emailError,
      passwordError: passwordError,
    );

    // Check if any validation errors
    if (emailError != null || passwordError != null) {
      return;
    }

    // Set loading state
    state = state.copyWith(isLoading: true, error: null);

    try {
      // Call repository to login
      await _authRepository.login(
        email: state.email,
        password: state.password,
      );

      // Success
      state = state.copyWith(
        isLoading: false,
        successMessage: 'Login successful!',
      );
    } catch (e) {
      // Error
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Clear error message
  void clearError() {
    state = state.copyWith(error: null);
  }

  /// Reset form
  void reset() {
    state = LoginState.initial();
  }
}
