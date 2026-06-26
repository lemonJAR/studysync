class LoginState {
  final String email;
  final String password;
  final bool rememberMe;
  final bool isLoading;
  final String? error;
  final String? successMessage;

  // Validation errors
  final String? emailError;
  final String? passwordError;

  LoginState({
    this.email = '',
    this.password = '',
    this.rememberMe = false,
    this.isLoading = false,
    this.error,
    this.successMessage,
    this.emailError,
    this.passwordError,
  });

  /// Create initial state
  factory LoginState.initial() {
    return LoginState();
  }

  /// Copy with - for immutability
  LoginState copyWith({
    String? email,
    String? password,
    bool? rememberMe,
    bool? isLoading,
    String? error,
    String? successMessage,
    String? emailError,
    String? passwordError,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      rememberMe: rememberMe ?? this.rememberMe,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      successMessage: successMessage ?? this.successMessage,
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
    );
  }

  @override
  String toString() => '''
LoginState(
  email: $email,
  password: $password,
  rememberMe: $rememberMe,
  isLoading: $isLoading,
  error: $error,
  successMessage: $successMessage,
)''';
}
