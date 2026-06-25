import 'package:hive/hive.dart';
import '../models/user.dart';
import '../repositories/auth_repository.dart';

/// Local authentication service implementation
class LocalAuthService implements AuthRepository {
  static const String _usersBoxName = 'users';
  static const String _currentUserKeyName = 'current_user';

  Box<dynamic>? _usersBox;
  User? _currentUser;

  /// Initialize service
  Future<void> init() async {
    try {
      _usersBox = Hive.box<dynamic>(_usersBoxName);
      
      // Load current user if exists
      final userJson = _usersBox?.get(_currentUserKeyName);
      if (userJson != null) {
        _currentUser = User.fromJson(Map<String, dynamic>.from(userJson as Map));
      }
    } catch (e) {
      throw Exception('Failed to initialize auth service: $e');
    }
  }

  @override
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // Validate inputs
      if (name.isEmpty) throw SignUpException('Name cannot be empty');
      if (email.isEmpty) throw SignUpException('Email cannot be empty');
      if (password.isEmpty) throw SignUpException('Password cannot be empty');

      // Check if email already exists
      final existingUser = _findUserByEmail(email);
      if (existingUser != null) {
        throw SignUpException('Email already registered');
      }

      // Create new user
      final newUser = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        email: email,
        createdAt: DateTime.now(),
      );

      // Save to local storage
      await _usersBox?.put(newUser.id, newUser.toJson());
      
      // Set as current user
      _currentUser = newUser;
      await _usersBox?.put(_currentUserKeyName, newUser.toJson());

    } catch (e) {
      if (e is SignUpException) {
        rethrow;
      }
      throw SignUpException('Sign up failed: $e');
    }
  }

  @override
  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      // Validate inputs
      if (email.isEmpty) throw LoginException('Email cannot be empty');
      if (password.isEmpty) throw LoginException('Password cannot be empty');

      // Find user (in real app, validate password)
      final user = _findUserByEmail(email);
      if (user == null) {
        throw InvalidCredentialsException('User not found');
      }

      // Set as current user
      _currentUser = user;
      await _usersBox?.put(_currentUserKeyName, user.toJson());

    } catch (e) {
      if (e is AuthException) {
        rethrow;
      }
      throw LoginException('Login failed: $e');
    }
  }

  @override
  Future<void> logout() async {
    try {
      _currentUser = null;
      await _usersBox?.delete(_currentUserKeyName);
    } catch (e) {
      throw AuthException('Logout failed: $e');
    }
  }

  @override
  bool isLoggedIn() {
    return _currentUser != null;
  }

  @override
  Future<User?> getCurrentUser() async {
    return _currentUser;
  }

  /// Helper: Find user by email
  User? _findUserByEmail(String email) {
    if (_usersBox == null) return null;
    
    try {
      for (int i = 0; i < _usersBox!.length; i++) {
        final userJson = _usersBox?.getAt(i);
        if (userJson != null) {
          final user = User.fromJson(Map<String, dynamic>.from(userJson as Map));
          if (user.email == email) {
            return user;
          }
        }
      }
    } catch (e) {
      // Skip invalid entries
    }
    return null;
  }
}