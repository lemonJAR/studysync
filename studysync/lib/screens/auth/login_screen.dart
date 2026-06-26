import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/spacing.dart';
import '../../providers/viewmodel_providers.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_text_field.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the ViewModel state
    final loginState = ref.watch(loginViewModelProvider);
    final viewModel = ref.read(loginViewModelProvider.notifier);

    // Show error if any
    if (loginState.error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(loginState.error!),
            backgroundColor: Colors.red,
          ),
        );
        viewModel.clearError();
      });
    }

    // Navigate on success
    if (loginState.successMessage != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(loginState.successMessage!),
            backgroundColor: Colors.green,
          ),
        );
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        });
      });
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Login',
        showBackButton: true,
        onBackPressed: () => Navigator.pop(context),
      ),
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.paddingMd,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSpacing.gapVerticalMd,

                // Title
                Text(
                  'Welcome Back',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AppSpacing.gapVerticalSm,

                // Subtitle
                Text(
                  'Sign in to continue managing your tasks',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
                ),
                AppSpacing.gapVerticalLg,

                // Email field
                CustomTextField(
                  label: 'Email',
                  hint: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email_outlined,
                  errorText: loginState.emailError,
                  onChanged: (value) {
                    viewModel.updateEmail(value);
                  },
                ),
                AppSpacing.gapVerticalLg,

                // Password field
                CustomTextField(
                  label: 'Password',
                  hint: 'Enter your password',
                  obscureText: true,
                  prefixIcon: Icons.lock_outline,
                  errorText: loginState.passwordError,
                  onChanged: (value) {
                    viewModel.updatePassword(value);
                  },
                ),
                AppSpacing.gapVerticalMd,

                // Forgot password link
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/forgotPassword'),
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                AppSpacing.gapVerticalMd,

                // Remember me checkbox
                Row(
                  children: [
                    Checkbox(
                      value: loginState.rememberMe,
                      onChanged: (value) {
                        viewModel.updateRememberMe(value ?? false);
                      },
                    ),
                    const Text('Remember me'),
                  ],
                ),
                AppSpacing.gapVerticalLg,

                // Login button
                PrimaryButton(
                  label: 'Login',
                  isLoading: loginState.isLoading,
                  isEnabled: !loginState.isLoading,
                  onPressed: () => viewModel.login(),
                ),
                AppSpacing.gapVerticalMd,

                // Sign up link - ✅ FIXED: Made clickable
                Center(
                  child: GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/signup'),
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(color: Colors.black87),
                        children: [
                          const TextSpan(text: "Don't have an account? "),
                          TextSpan(
                            text: 'Sign Up',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                AppSpacing.gapVerticalXl,
              ],
            ),
          ),
        ),
      ),
    );
  }
}