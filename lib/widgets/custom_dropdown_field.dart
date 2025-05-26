import 'package:dooit/utils/app_styles.dart';
import 'package:flutter/material.dart';

class CustomDropdownField extends StatefulWidget {
  final String label;
  final IconData? prefixIcon;
  final List<String> items;

  const CustomDropdownField({
    super.key,
    required this.label,
    required this.items,
    this.prefixIcon,
  });

  @override
  State<CustomDropdownField> createState() => _CustomDropdownFieldState();
}

class _CustomDropdownFieldState extends State<CustomDropdownField> {
  String? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            widget.label,
            style: AppTextStyles.inputFieldText,
          ),
        ),
        DropdownButtonFormField<String>(
          isExpanded: true,
          value: _selectedItem,
          onChanged: (String? newValue) {
            setState(() {
              _selectedItem = newValue;
            });
          },
          items: widget.items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                ),
              ),
            );
          }).toList(),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            prefixIcon: widget.prefixIcon != null 
                ? Icon(
                    widget.prefixIcon,
                    color: AppColors.grey1,
                  ) 
                : null,
            hintText: 'Select ${widget.label.toLowerCase()}',
            hintStyle: const TextStyle(color: AppColors.grey1),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              borderSide: BorderSide(color: AppColors.primary, width: 2),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              borderSide: BorderSide(color: Colors.grey, width: 1),
            ),
          ),
          dropdownColor: Colors.white,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.primary,
          ),
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}