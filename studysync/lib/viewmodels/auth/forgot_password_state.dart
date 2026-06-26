/// State for forgot password screen
class ForgotPasswordState {
  final String email;
  final bool isLoading;
  final String? error;
  final String? successMessage;
  final String? emailError;

  ForgotPasswordState({
    this.email = '',
    this.isLoading = false,
    this.error,
    this.successMessage,
    this.emailError,
  });

  /// Create initial state
  factory ForgotPasswordState.initial() {
    return ForgotPasswordState();
  }

  /// Copy with - for immutability
  ForgotPasswordState copyWith({
    String? email,
    bool? isLoading,
    String? error,
    String? successMessage,
    String? emailError,
  }) {
    return ForgotPasswordState(
      email: email ?? this.email,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      successMessage: successMessage ?? this.successMessage,
      emailError: emailError ?? this.emailError,
    );
  }

  @override
  String toString() => '''
ForgotPasswordState(
  email: $email,
  isLoading: $isLoading,
  error: $error,
  successMessage: $successMessage,
)''';
}
