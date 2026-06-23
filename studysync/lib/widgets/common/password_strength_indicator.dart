import 'package:flutter/material.dart';

/// Enum for password strength levels
enum PasswordStrength {
  weak,
  fair,
  good,
  strong,
}

/// Widget to display password strength
class PasswordStrengthIndicator extends StatelessWidget {
  final String password;
  final double height;
  final double borderRadius;

  const PasswordStrengthIndicator({
    Key? key,
    required this.password,
    this.height = 8,
    this.borderRadius = 4,
  }) : super(key: key);

  /// Calculate password strength
  PasswordStrength _calculateStrength(String password) {
    if (password.isEmpty) {
      return PasswordStrength.weak;
    }

    int strength = 0;

    // Length check
    if (password.length >= 6) strength++;
    if (password.length >= 8) strength++;
    if (password.length >= 12) strength++;

    // Character variety checks
    if (password.contains(RegExp(r'[a-z]'))) strength++;
    if (password.contains(RegExp(r'[A-Z]'))) strength++;
    if (password.contains(RegExp(r'[0-9]'))) strength++;
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) strength++;

    if (strength <= 2) {
      return PasswordStrength.weak;
    } else if (strength <= 4) {
      return PasswordStrength.fair;
    } else if (strength <= 5) {
      return PasswordStrength.good;
    } else {
      return PasswordStrength.strong;
    }
  }

  /// Get color for strength level
  Color _getStrengthColor(PasswordStrength strength) {
    switch (strength) {
      case PasswordStrength.weak:
        return Colors.red;
      case PasswordStrength.fair:
        return Colors.orange;
      case PasswordStrength.good:
        return Colors.yellow[700]!;
      case PasswordStrength.strong:
        return Colors.green;
    }
  }

  /// Get label for strength level
  String _getStrengthLabel(PasswordStrength strength) {
    switch (strength) {
      case PasswordStrength.weak:
        return 'Weak';
      case PasswordStrength.fair:
        return 'Fair';
      case PasswordStrength.good:
        return 'Good';
      case PasswordStrength.strong:
        return 'Strong';
    }
  }

  /// Get strength percentage (0-1)
  double _getStrengthPercentage(PasswordStrength strength) {
    switch (strength) {
      case PasswordStrength.weak:
        return 0.25;
      case PasswordStrength.fair:
        return 0.5;
      case PasswordStrength.good:
        return 0.75;
      case PasswordStrength.strong:
        return 1.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final strength = _calculateStrength(password);
    final color = _getStrengthColor(strength);
    final label = _getStrengthLabel(strength);
    final percentage = _getStrengthPercentage(strength);

    if (password.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Strength bar
        ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: LinearProgressIndicator(
            value: percentage,
            minHeight: height,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
        const SizedBox(height: 8),
        // Strength label
        Text(
          'Password Strength: $label',
          style: TextStyle(
            fontSize: 12,
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        // Requirements
        _PasswordRequirements(password: password),
      ],
    );
  }
}

/// Widget to show password requirements checklist
class _PasswordRequirements extends StatelessWidget {
  final String password;

  const _PasswordRequirements({
    Key? key,
    required this.password,
  }) : super(key: key);

  bool _hasMinLength() => password.length >= 6;
  bool _hasUpperCase() => password.contains(RegExp(r'[A-Z]'));
  bool _hasLowerCase() => password.contains(RegExp(r'[a-z]'));
  bool _hasNumber() => password.contains(RegExp(r'[0-9]'));
  bool _hasSpecialChar() => password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _RequirementItem(
          label: 'At least 6 characters',
          isMet: _hasMinLength(),
        ),
        _RequirementItem(
          label: 'At least one uppercase letter',
          isMet: _hasUpperCase(),
        ),
        _RequirementItem(
          label: 'At least one lowercase letter',
          isMet: _hasLowerCase(),
        ),
        _RequirementItem(
          label: 'At least one number',
          isMet: _hasNumber(),
        ),
        _RequirementItem(
          label: r'At least one special character (!@#$%)',
          isMet: _hasSpecialChar(),
        ),
      ],
    );
  }
}

/// Single requirement item
class _RequirementItem extends StatelessWidget {
  final String label;
  final bool isMet;

  const _RequirementItem({
    Key? key,
    required this.label,
    required this.isMet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        children: [
          Icon(
            isMet ? Icons.check_circle : Icons.radio_button_unchecked,
            size: 16,
            color: isMet ? Colors.green : Colors.grey,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isMet ? Colors.green : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}