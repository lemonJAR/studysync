import 'package:flutter/material.dart';
import '../../../config/spacing.dart';
import '../../../widgets/widgets.dart';
import '../../../widgets/common/password_strength_indicator.dart';
import '../../../widgets/common/terms_checkbox.dart';

/// Sign up form widget
class SignUpForm extends StatefulWidget {
  final VoidCallback? onSignUpPressed;
  final bool isLoading;
  final VoidCallback? onLoginPressed;

  const SignUpForm({
    Key? key,
    this.onSignUpPressed,
    this.isLoading = false,
    this.onLoginPressed,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  bool _agreeToTerms = false;
  bool _showPasswordRequirements = false;
  String? _passwordError;
  String? _nameError;
  String? _emailError;
  String? _confirmPasswordError;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  /// Validate name
  String? _validateName(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Full name is required';
    }
    if ((value?.length ?? 0) < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  /// Validate email
  String? _validateEmail(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    if (!emailRegex.hasMatch(value ?? '')) {
      return 'Please enter a valid email';
    }
    return null;
  }

  /// Validate password
  String? _validatePassword(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Password is required';
    }
    if ((value?.length ?? 0) < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  /// Validate password confirmation
  String? _validateConfirmPassword(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Please confirm your password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  /// Handle form submission
  void _handleSignUp() {
    if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please agree to the Terms & Conditions'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      // All validation passed
      widget.onSignUpPressed?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name field
            CustomTextField(
              label: 'Full Name',
              hint: 'Enter your full name',
              controller: _nameController,
              keyboardType: TextInputType.name,
              prefixIcon: Icons.person_outline,
              validator: _validateName,
              onChanged: (value) {
                setState(() {
                  _nameError = _validateName(value);
                });
              },
            ),
            AppSpacing.gapVerticalLg,

            // Email field
            EmailTextField(
              controller: _emailController,
              onChanged: (value) {
                setState(() {
                  _emailError = _validateEmail(value);
                });
              },
            ),
            AppSpacing.gapVerticalLg,

            // Password field
            CustomTextField(
              label: 'Password',
              hint: 'Enter a strong password',
              controller: _passwordController,
              obscureText: true,
              prefixIcon: Icons.lock_outline,
              validator: _validatePassword,
              onChanged: (value) {
                setState(() {
                  _showPasswordRequirements = value.isNotEmpty;
                  _passwordError = _validatePassword(value);
                });
              },
            ),
            AppSpacing.gapVerticalMd,

            // Password strength indicator
            if (_showPasswordRequirements)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PasswordStrengthIndicator(
                    password: _passwordController.text,
                  ),
                  AppSpacing.gapVerticalLg,
                ],
              ),

            // Confirm password field
            CustomTextField(
              label: 'Confirm Password',
              hint: 'Re-enter your password',
              controller: _confirmPasswordController,
              obscureText: true,
              prefixIcon: Icons.lock_outline,
              validator: _validateConfirmPassword,
              onChanged: (value) {
                setState(() {
                  _confirmPasswordError = _validateConfirmPassword(value);
                });
              },
            ),
            AppSpacing.gapVerticalLg,

            // Terms checkbox
            TermsCheckbox(
              isChecked: _agreeToTerms,
              onChanged: (value) {
                setState(() {
                  _agreeToTerms = value;
                });
              },
            ),
            AppSpacing.gapVerticalLg,

            // Sign up button
            PrimaryButton(
              label: 'Create Account',
              onPressed: _handleSignUp,
              isLoading: widget.isLoading,
              isEnabled: !widget.isLoading,
            ),
            AppSpacing.gapVerticalMd,

            // Login link
            Center(
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
            AppSpacing.gapVerticalXl,
          ],
        ),
      ),
    );
  }
}
