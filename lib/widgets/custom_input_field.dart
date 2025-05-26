import 'package:dooit/utils/app_styles.dart';
import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  final String label;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;
  final int? minLines;
  final int? maxLines;
  final bool isDateField;
  final bool isTimeField;

  const CustomInputField({
    super.key,
    required this.label,
    this.prefixIcon,
    this.keyboardType,
    this.minLines,
    this.maxLines,
    this.isDateField = false,
    this.isTimeField = false,
  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  final TextEditingController _controller = TextEditingController();

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _controller.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _controller.text = picked.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determine if this is a multiline field
    bool isMultiline = widget.keyboardType == TextInputType.multiline;

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
        TextField(
          controller: _controller,
          keyboardType: widget.keyboardType,
          cursorColor: AppColors.primary,
          minLines: isMultiline ? (widget.minLines ?? 3) : null,
          maxLines:
              isMultiline ? (widget.maxLines ?? 6) : (widget.maxLines ?? 1),
          readOnly: widget.isDateField || widget.isTimeField,
          onTap:
              widget.isDateField
                  ? _selectDate
                  : widget.isTimeField
                  ? _selectTime
                  : null,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            prefixIcon:
                widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
            suffixIcon:
                widget.isDateField
                    ? Icon(Icons.calendar_today, color: AppColors.primary)
                    : widget.isTimeField
                    ? Icon(Icons.access_time, color: AppColors.primary)
                    : null,
            hintText:
                widget.isDateField
                    ? 'Select date'
                    : widget.isTimeField
                    ? 'Select time'
                    : 'Enter ${widget.label.toLowerCase()}',
            hintStyle: const TextStyle(color: AppColors.grey1),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              borderSide: BorderSide(color: AppColors.primary, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
