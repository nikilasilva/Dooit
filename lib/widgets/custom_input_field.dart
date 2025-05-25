import 'package:dooit/utils/app_styles.dart';
import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  final String label;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;
  const CustomInputField({
    super.key,
    required this.label,
    this.prefixIcon,
    this.keyboardType,
  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: widget.keyboardType,
      cursorColor: AppColors.primary,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
        labelText: widget.label,
        labelStyle: const TextStyle(color: AppColors.grey1),
        floatingLabelStyle: const TextStyle(color: AppColors.primary),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
    );
  }
}
