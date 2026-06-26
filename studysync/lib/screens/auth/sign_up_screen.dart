import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/spacing.dart';
import '../../providers/viewmodel_providers.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_text_field.dart';
import '../../widgets/common/password_strength_indicator.dart';
import '../../widgets/common/terms_checkbox.dart';

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the ViewModel state
    final signUpState = ref.watch(signUpViewModelProvider);
    final viewModel = ref.read(signUpViewModelProvider.notifier);

    // Show error if any
    if (signUpState.error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(signUpState.error!),
            backgroundColor: Colors.red,
          ),
        );
        viewModel.clearError();
      });
    }

    // Navigate on success
    if (signUpState.successMessage != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(signUpState.successMessage!),
            backgroundColor: Colors.green,
          ),
        );
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushNamed(context, '/login');
        });
      });
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Create Account',
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

                // Name field
                CustomTextField(
                  label: 'Full Name',
                  hint: 'Enter your full name',
                  prefixIcon: Icons.person_outline,
                  errorText: signUpState.nameError,
                  onChanged: (value) {
                    viewModel.updateName(value);
                  },
                ),
                AppSpacing.gapVerticalLg,

                // Email field
                CustomTextField(
                  label: 'Email',
                  hint: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email_outlined,
                  errorText: signUpState.emailError,
                  onChanged: (value) {
                    viewModel.updateEmail(value);
                  },
                ),
                AppSpacing.gapVerticalLg,

                // Password field
                CustomTextField(
                  label: 'Password',
                  hint: 'Enter a strong password',
                  obscureText: true,
                  prefixIcon: Icons.lock_outline,
                  errorText: signUpState.passwordError,
                  onChanged: (value) {
                    viewModel.updatePassword(value);
                  },
                ),
                AppSpacing.gapVerticalMd,

                // Password strength
                if (signUpState.password.isNotEmpty)
                  Column(
                    children: [
                      PasswordStrengthIndicator(password: signUpState.password),
                      AppSpacing.gapVerticalLg,
                    ],
                  ),

                // Confirm password
                CustomTextField(
                  label: 'Confirm Password',
                  hint: 'Re-enter your password',
                  obscureText: true,
                  prefixIcon: Icons.lock_outline,
                  errorText: signUpState.confirmPasswordError,
                  onChanged: (value) {
                    viewModel.updateConfirmPassword(value);
                  },
                ),
                AppSpacing.gapVerticalLg,

                // Terms checkbox
                TermsCheckbox(
                  isChecked: signUpState.agreeToTerms,
                  onChanged: (value) {
                    viewModel.updateTermsAgreement(value);
                  },
                ),
                AppSpacing.gapVerticalLg,

                // Sign up button
                PrimaryButton(
                  label: 'Create Account',
                  isLoading: signUpState.isLoading,
                  isEnabled: !signUpState.isLoading,
                  onPressed: () => viewModel.signUp(),
                ),
                AppSpacing.gapVerticalMd,

                // Login link - ✅ FIXED: Made clickable
                Center(
                  child: GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/login'),
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(color: Colors.black87),
                        children: [
                          const TextSpan(text: 'Already have an account? '),
                          TextSpan(
                            text: 'Login',
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