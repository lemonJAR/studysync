import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/spacing.dart';
import '../../providers/viewmodel_providers.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_text_field.dart';

class ForgotPasswordScreen extends ConsumerWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the ViewModel state
    final forgotState = ref.watch(forgotPasswordViewModelProvider);
    final viewModel = ref.read(forgotPasswordViewModelProvider.notifier);

    // Show error if any
    if (forgotState.error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(forgotState.error!),
            backgroundColor: Colors.red,
          ),
        );
        viewModel.clearError();
      });
    }

    // Navigate on success
    if (forgotState.successMessage != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(forgotState.successMessage!),
            backgroundColor: Colors.green,
          ),
        );
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushNamed(context, '/login');
        });
      });
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Forgot Password',
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
                  'Reset Password',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AppSpacing.gapVerticalSm,

                // Subtitle
                Text(
                  'Enter your email address and we\'ll send you a link to reset your password',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
                ),
                AppSpacing.gapVerticalLg,

                // Email field
                CustomTextField(
                  label: 'Email Address',
                  hint: 'Enter your registered email',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email_outlined,
                  errorText: forgotState.emailError,
                  onChanged: (value) {
                    viewModel.updateEmail(value);
                  },
                ),
                AppSpacing.gapVerticalLg,

                // Send button
                PrimaryButton(
                  label: 'Send Reset Link',
                  isLoading: forgotState.isLoading,
                  isEnabled: !forgotState.isLoading,
                  onPressed: () => viewModel.sendResetEmail(),
                ),
                AppSpacing.gapVerticalMd,

                // Back to login link
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Back to Login'),
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
