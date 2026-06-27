import 'package:hive/hive.dart';
import '../models/user.dart';
import '../repositories/auth_repository.dart';

/// Local authentication service implementation
class LocalAuthService implements AuthRepository {
  static const String _usersBoxName = 'users';
  static const String _currentUserKeyName = 'current_user';

  Box<dynamic>? _usersBox;
  User? _currentUser;
  bool _initialized = false;  // ← NEW: Guard against multiple inits

  /// Initialize service - only runs once
  Future<void> init() async {
    if (_initialized) return;

    try {
      // Box should already be open from HiveConfig.initHive()
      _usersBox = Hive.box<dynamic>(_usersBoxName);
      
      // Load current user if exists
      final userJson = _usersBox?.get(_currentUserKeyName);
      if (userJson != null) {
        _currentUser = User.fromJson(Map<String, dynamic>.from(userJson as Map));
      }
      
      _initialized = true;
    } catch (e) {
      // If box doesn't exist, try to open it
      try {
        _usersBox = await Hive.openBox<dynamic>(_usersBoxName);
        _initialized = true;
      } catch (openError) {
        print('Failed to initialize auth service: $openError');
        _initialized = true; // Mark as initialized anyway to prevent infinite retries
      }
    }
  }

  @override
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    await init();  // ← ADDED: Ensure initialized

    try {
      if (name.isEmpty) throw SignUpException('Name cannot be empty');
      if (email.isEmpty) throw SignUpException('Email cannot be empty');
      if (password.isEmpty) throw SignUpException('Password cannot be empty');

      final existingUser = _findUserByEmail(email);
      if (existingUser != null) {
        throw SignUpException('Email already registered');
      }

      final newUser = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        email: email,
        createdAt: DateTime.now(),
      );

      await _usersBox?.put(newUser.id, newUser.toJson());
      
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
    await init();  // ← ADDED: Ensure initialized

    try {
      if (email.isEmpty) throw LoginException('Email cannot be empty');
      if (password.isEmpty) throw LoginException('Password cannot be empty');

      final user = _findUserByEmail(email);
      if (user == null) {
        throw InvalidCredentialsException('User not found');
      }

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
    await init();  // ← ADDED: Ensure initialized

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
    await init();  // ← ADDED: Ensure initialized
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