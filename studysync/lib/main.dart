import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'config/hive_config.dart';
import 'services/auth_service.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await HiveConfig.initHive();
  
  // Initialize auth service ← THIS IS THE KEY FIX
  final authService = LocalAuthService();
  await authService.init();
  
  runApp(
    ProviderScope(
      child: const StudySyncApp(),
    ),
  );
}