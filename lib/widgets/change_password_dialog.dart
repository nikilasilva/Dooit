import 'package:dooit/providers/auth_provider.dart';
import 'package:dooit/utils/app_styles.dart';
import 'package:dooit/utils/snackbar_helper.dart';
import 'package:dooit/widgets/action_buttons_row.dart';
import 'package:dooit/widgets/custom_password_field.dart';
import 'package:dooit/widgets/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    final oldPassword = _oldPasswordController.text.trim();
    final newPassword = _newPasswordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (oldPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
      SnackbarHelper.showErrorSnackBar(context, "All fields are required");
      return;
    }

    if (newPassword != confirmPassword) {
      SnackbarHelper.showErrorSnackBar(context, "New password do not match");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final success = await authProvider.changePassword(oldPassword, newPassword);

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    if (success) {
      // Parent screen will handle the success message.
      Navigator.pop(context);
    } else {
      SnackbarHelper.showErrorSnackBar(
        context,
        authProvider.errorMessage ?? "Failed to change password",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: AppColors.white,
      child: LoadingOverlay(
        isLoading: _isLoading,
        message: "Updating password...",
        // The child of the LoadingOverlay is your form content
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
                  // Prevent closing the dialog while loading
                  if (!_isLoading) {
                    Navigator.pop(context);
                  }
                },
                // Disable the submit button while loading
                onSubmit: _isLoading ? null : () => _handleSubmit(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
