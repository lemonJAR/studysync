import 'package:flutter/material.dart';
import '../../config/spacing.dart';
import '../../widgets/common/custom_app_bar.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Login',
        showBackButton: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.paddingMd,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock_outline,
                  size: 80,
                  color: Theme.of(context).primaryColor,
                ),
                AppSpacing.gapVerticalLg,
                Text(
                  'Login Screen',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                AppSpacing.gapVerticalMd,
                Text(
                  'Coming on Day 5',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                AppSpacing.gapVerticalXl,
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Back to Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
