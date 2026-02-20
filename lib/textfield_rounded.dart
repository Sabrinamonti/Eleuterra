import 'package:eleuterra_app/theme/app_text.dart';
import 'package:flutter/material.dart';

class RoundedInput extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Color borderColor;

  const RoundedInput({
    required this.hint,
    required this.controller,
    required this.borderColor,
    this.obscureText = false,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: AppTextStyles.medium,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTextStyles.medium.copyWith(color: Color(0xFF7F7F7F)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: borderColor, width: 1.2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: borderColor, width: 1.6),
        ),
      ),
    );
  }
}