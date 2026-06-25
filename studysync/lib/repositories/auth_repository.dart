import '../models/user.dart';

/// Abstract repository for authentication operations
abstract class AuthRepository {
  /// Sign up with email and password
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  });

  /// Login with email and password
  Future<void> login({
    required String email,
    required String password,
  });

  /// Logout current user
  Future<void> logout();

  /// Check if user is logged in
  bool isLoggedIn();

  /// Get current user
  Future<User?> getCurrentUser();
}

/// Custom exceptions
class AuthException implements Exception {
  final String message;
  AuthException(this.message);

  @override
  String toString() => message;
}

class SignUpException extends AuthException {
  SignUpException(String message) : super(message);
}

class LoginException extends AuthException {
  LoginException(String message) : super(message);
}

class InvalidCredentialsException extends AuthException {
  InvalidCredentialsException(String message) : super(message);
}