// lib/viewmodels/auth/sign_up_state.dart

class SignUpState {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final bool agreeToTerms;
  final bool isLoading;
  final String? error;
  final String? successMessage;  // ← CHANGED: bool? success → String? successMessage
  
  // Validation errors
  final String? nameError;
  final String? emailError;
  final String? passwordError;
  final String? confirmPasswordError;

  SignUpState({
    this.name = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.agreeToTerms = false,
    this.isLoading = false,
    this.error,
    this.successMessage,  // ← CHANGED
    this.nameError,
    this.emailError,
    this.passwordError,
    this.confirmPasswordError,
  });

  // CopyWith for immutability
  SignUpState copyWith({
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
    bool? agreeToTerms,
    bool? isLoading,
    String? error,
    String? successMessage,  // ← CHANGED
    String? nameError,
    String? emailError,
    String? passwordError,
    String? confirmPasswordError,
  }) {
    return SignUpState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      agreeToTerms: agreeToTerms ?? this.agreeToTerms,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      successMessage: successMessage ?? this.successMessage,  // ← CHANGED
      nameError: nameError ?? this.nameError,
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
      confirmPasswordError: confirmPasswordError ?? this.confirmPasswordError,
    );
  }

  // Initial state
  factory SignUpState.initial() {
    return SignUpState();
  }

  @override
  String toString() => '''
SignUpState(
  name: $name,
  email: $email,
  agreeToTerms: $agreeToTerms,
  isLoading: $isLoading,
  error: $error,
  successMessage: $successMessage,
)''';
}