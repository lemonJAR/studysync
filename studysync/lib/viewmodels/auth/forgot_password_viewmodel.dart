import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'forgot_password_state.dart';

class ForgotPasswordViewModel extends StateNotifier<ForgotPasswordState> {
  ForgotPasswordViewModel() : super(ForgotPasswordState.initial());

  // Update methods
  void updateEmail(String email) {
    final error = _validateEmail(email);
    state = state.copyWith(email: email, emailError: error);
  }

  // Validation methods
  String? _validateEmail(String email) {
    if (email.isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    if (!emailRegex.hasMatch(email)) return 'Please enter a valid email';
    return null;
  }

  /// Send reset email
  Future<void> sendResetEmail() async {
    // Validate email
    final emailError = _validateEmail(state.email);

    state = state.copyWith(emailError: emailError);

    if (emailError != null) {
      return;
    }

    // Set loading state
    state = state.copyWith(isLoading: true, error: null);

    try {
      // Simulate sending reset email
      await Future.delayed(const Duration(seconds: 2));

      state = state.copyWith(
        isLoading: false,
        successMessage: 'Password reset email sent! Check your inbox.',
      );
    } catch (e) {
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
    state = ForgotPasswordState.initial();
  }
}
