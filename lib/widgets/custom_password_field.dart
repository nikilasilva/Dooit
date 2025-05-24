import 'package:dooit/utils/app_styles.dart';
import 'package:flutter/material.dart';

class CustomPasswordField extends StatefulWidget {
  final String label;
  final TextEditingController? controller;
  const CustomPasswordField({super.key, required this.label, this.controller});

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _obscure,
      cursorColor: AppColors.primary,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(Icons.lock_outline),
        labelText: widget.label,
        labelStyle: const TextStyle(color: Colors.grey),
        floatingLabelStyle: const TextStyle(color: AppColors.primary),
        suffixIcon: IconButton(onPressed: () {
          setState(() {
            _obscure = !_obscure;
          });
        }, icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility)),
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
