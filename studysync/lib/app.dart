import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'config/theme.dart';
import 'config/constants.dart';
import 'config/routes.dart';
import 'providers/providers.dart';
import 'screens/auth/sign_up_screen.dart';


class StudySyncApp extends ConsumerWidget {
  const StudySyncApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeModeProvider);

    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.getLightTheme(),
      darkTheme: AppTheme.getDarkTheme(),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      
      // Home screen - start with sign up
      home: const SignUpScreen(),
      
      // Named route generator
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}