import 'package:dooit/utils/app_styles.dart';
import 'package:dooit/widgets/action_buttons_row.dart';
import 'package:dooit/widgets/custom_password_field.dart';
import 'package:flutter/material.dart';

class ChangePasswordDialog extends StatefulWidget {
  const ChangePasswordDialog({super.key});

  @override
  State<ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    final oldPassword = _oldPasswordController.text.trim();
    final newPassword = _newPasswordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (oldPassword.isNotEmpty &&
        newPassword.isNotEmpty &&
        confirmPassword.isNotEmpty) {
      if (newPassword == confirmPassword) {
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('New passwords do not match')),
        );
      }
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('All fields are required')));
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Change Password', style: AppTextStyles.subHeading),
            const SizedBox(height: 16),
            CustomPasswordField(
              label: "Old password",
              controller: _oldPasswordController,
            ),
            const SizedBox(height: 16),
            CustomPasswordField(
              label: "New password",
              controller: _newPasswordController,
            ),
            const SizedBox(height: 16),
            CustomPasswordField(
              label: "Confirm New password",
              controller: _confirmPasswordController,
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
