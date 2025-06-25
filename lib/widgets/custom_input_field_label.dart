import 'package:DooIt/utils/app_styles.dart';
import 'package:flutter/material.dart';

class CustomInputFieldLabel extends StatefulWidget {
  final String label;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const CustomInputFieldLabel({
    super.key,
    required this.label,
    this.prefixIcon,
    this.keyboardType,
    this.controller,
    this.validator,
  });

  @override
  State<CustomInputFieldLabel> createState() => _CustomInputFieldLabelState();
}

class _CustomInputFieldLabelState extends State<CustomInputFieldLabel> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
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
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
      ),
    );
  }
}
