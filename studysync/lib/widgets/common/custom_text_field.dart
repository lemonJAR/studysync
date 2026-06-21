import 'package:flutter/material.dart';

/// Reusable text field widget
class CustomTextField extends StatefulWidget {
  final String label;
  final String? hint;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final int? maxLines;
  final int? minLines;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconPressed;
  final String? errorText;
  final bool isEnabled;
  final int? maxLength;

  const CustomTextField({
    Key? key,
    required this.label,
    this.hint,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines = 1,
    this.validator,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.errorText,
    this.isEnabled = true,
    this.maxLength,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _isObscured;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white70
                  : Colors.black87,
            ),
          ),
        ),
        // Text Field
        TextFormField(
          controller: widget.controller,
          focusNode: _focusNode,
          keyboardType: widget.keyboardType,
          obscureText: _isObscured,
          maxLines: _isObscured ? 1 : widget.maxLines,
          minLines: widget.minLines,
          enabled: widget.isEnabled,
          maxLength: widget.maxLength,
          validator: widget.validator,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            hintText: widget.hint,
            prefixIcon: widget.prefixIcon != null
                ? Icon(widget.prefixIcon)
                : null,
            suffixIcon: widget.suffixIcon != null || widget.obscureText
                ? GestureDetector(
                    onTap: widget.onSuffixIconPressed ?? () {
                      setState(() {
                        if (widget.obscureText) {
                          _isObscured = !_isObscured;
                        }
                      });
                    },
                    child: Icon(
                      widget.obscureText
                          ? (_isObscured ? Icons.visibility_off : Icons.visibility)
                          : widget.suffixIcon,
                    ),
                  )
                : null,
            errorText: widget.errorText,
            counterText: '', // Hide character counter
          ),
        ),
      ],
    );
  }
}

/// Email text field with validation
class EmailTextField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final void Function(String)? onChanged;

  const EmailTextField({
    Key? key,
    this.label = 'Email',
    this.controller,
    this.onChanged,
  }) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: label,
      hint: 'Enter your email',
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      prefixIcon: Icons.email_outlined,
      validator: _validateEmail,
      onChanged: onChanged,
    );
  }
}

/// Password text field with validation
class PasswordTextField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  const PasswordTextField({
    Key? key,
    this.label = 'Password',
    this.controller,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: label,
      hint: 'Enter your password',
      controller: controller,
      obscureText: true,
      prefixIcon: Icons.lock_outlined,
      validator: validator ?? _validatePassword,
      onChanged: onChanged,
    );
  }

  String? _validatePassword(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Password is required';
    }
    if ((value?.length ?? 0) < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
}
