import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'config/hive_config.dart';
import 'app.dart';

void main() async {
  // Initialize Hive database
  await HiveConfig.initHive();
  
  // Run app with Riverpod 
  runApp(
    const ProviderScope(
      child: StudySyncApp(),
    ),
  );
}
