import 'package:dooit/utils/app_styles.dart';
import 'package:dooit/widgets/action_buttons_row.dart';
import 'package:flutter/material.dart';

class CustomInputDialog extends StatefulWidget {
  final String title;
  final String hintText;
  final String initialValue;
  final String? description;
  final void Function(String value) onSubmit;

  const CustomInputDialog({
    super.key,
    required this.title,
    required this.hintText,
    this.description,
    required this.onSubmit,
    this.initialValue = '',
  });

  @override
  State<CustomInputDialog> createState() => _CustomInputDialogState();
}

class _CustomInputDialogState extends State<CustomInputDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  // Handle dialog submit
  void _handleSubmit() {
    final value = _controller.text.trim();
    if (value.isNotEmpty) {
      widget.onSubmit(value);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(widget.title, style: AppTextStyles.subHeading),
            ),
            if (widget.description != null) ...[
              const SizedBox(height: 12),
              Text(widget.description!, style: AppTextStyles.descriptionText),
            ],
            const SizedBox(height: 16),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: widget.hintText,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primary),
                  borderRadius: BorderRadius.circular(15),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primary),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ActionButtonsRow(
              onCancel: () {
                Navigator.pop(context);
              },
              onSubmit: _handleSubmit,
            ),
          ],
        ),
      ),
    );
  }
}
