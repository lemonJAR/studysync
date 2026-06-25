import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../repositories/auth_repository.dart';
import 'sign_up_state.dart';

class SignUpViewModel extends StateNotifier<SignUpState> {
  final AuthRepository _authRepository;

  SignUpViewModel(this._authRepository) : super(SignUpState.initial());

  // Update methods
  void updateName(String name) {
    final error = _validateName(name);
    state = state.copyWith(name: name, nameError: error);
  }

  void updateEmail(String email) {
    final error = _validateEmail(email);
    state = state.copyWith(email: email, emailError: error);
  }

  void updatePassword(String password) {
    final error = _validatePassword(password);
    state = state.copyWith(password: password, passwordError: error);
  }

  void updateConfirmPassword(String password) {
    final error = _validateConfirmPassword(password);
    state = state.copyWith(confirmPassword: password, confirmPasswordError: error);
  }

  void updateTermsAgreement(bool agreed) {
    state = state.copyWith(agreeToTerms: agreed);
  }

  // Validation methods
  String? _validateName(String name) {
    if (name.isEmpty) return 'Full name is required';
    if (name.length < 2) return 'Name must be at least 2 characters';
    return null;
  }

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

  String? _validateConfirmPassword(String password) {
    if (password.isEmpty) return 'Please confirm your password';
    if (password != state.password) return 'Passwords do not match';
    return null;
  }

  /// Main sign up method
  Future<void> signUp() async {
    // Validate all fields first
    final nameError = _validateName(state.name);
    final emailError = _validateEmail(state.email);
    final passwordError = _validatePassword(state.password);
    final confirmError = _validateConfirmPassword(state.confirmPassword);

    // Update state with validation errors
    state = state.copyWith(
      nameError: nameError,
      emailError: emailError,
      passwordError: passwordError,
      confirmPasswordError: confirmError,
    );

    // Check if any validation errors
    if (nameError != null || emailError != null || passwordError != null || confirmError != null) {
      return;
    }

    // Check terms agreement
    if (!state.agreeToTerms) {
      state = state.copyWith(error: 'Please agree to Terms & Conditions');
      return;
    }

    // Set loading state
    state = state.copyWith(isLoading: true, error: null);

    try {
      // Call repository to sign up
      await _authRepository.signUp(
        name: state.name,
        email: state.email,
        password: state.password,
      );

      // Success
      state = state.copyWith(
        isLoading: false,
        successMessage: 'Account created successfully!',
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
    state = SignUpState.initial();
  }
}