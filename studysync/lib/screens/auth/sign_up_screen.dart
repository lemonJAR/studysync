import 'package:flutter/material.dart';
import '../../config/spacing.dart';
import '../../widgets/common/custom_app_bar.dart';
import 'widgets/sign_up_form.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isLoading = false;

  /// Handle sign up action
  void _handleSignUp() {
    setState(() {
      _isLoading = true;
    });

    // Simulate sign up process
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Account created successfully!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );

      // Navigate to login screen
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushNamed(context, '/login');
      });
    });
  }

  /// Handle login link press
  void _handleLoginPressed() {
    Navigator.pushNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Create Account',
        showBackButton: true,
        onBackPressed: () => Navigator.pop(context),
      ),
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.paddingMd,
          child: Column(
            children: [
              // Header
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppSpacing.gapVerticalMd,
                      // Title
                      Text(
                        'Welcome to StudySync',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      AppSpacing.gapVerticalSm,
                      // Subtitle
                      Text(
                        'Create your account to manage tasks and deadlines',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                      AppSpacing.gapVerticalLg,
                      // Form
                      SignUpForm(
                        isLoading: _isLoading,
                        onSignUpPressed: _handleSignUp,
                        onLoginPressed: _handleLoginPressed,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
