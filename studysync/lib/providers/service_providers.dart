import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/auth_repository.dart';
import '../services/auth_service.dart';

/// Auth Repository Provider
/// Creates a singleton instance of LocalAuthService
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return LocalAuthService();
});