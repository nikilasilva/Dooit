import 'package:dooit/utils/app_styles.dart';
import 'package:dooit/widgets/action_buttons_row.dart';
import 'package:flutter/material.dart';

class CustomConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback? onCancel;
  final VoidCallback onSubmit;
  const CustomConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onSubmit,
    this.onCancel,
  });

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
            // Title
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: AppTextStyles.subHeading,
              ),
            ),
            const SizedBox(height: 16),
            // Message
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                message,
                style: AppTextStyles.confirmationText,
              ),
            ),
            const SizedBox(height: 32),
            // Action buttons
            ActionButtonsRow(
              onCancel: () {
                Navigator.pop(context);
              },
              onSubmit: onSubmit,
            ),
          ],
        ),
      ),
    );
  }
}
