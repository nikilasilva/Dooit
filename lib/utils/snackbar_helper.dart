import 'package:DooIt/utils/app_styles.dart';
import 'package:flutter/material.dart';

class SnackbarHelper {
  static void showSuccessSnackBar(BuildContext context, String message) {
    _showCustomSnackBar(
      context: context,
      message: message,
      backgroundColor: Colors.green.shade700,
      icon: Icons.check_circle,
    );
  }

  static void showErrorSnackBar(BuildContext context, String message) {
    _showCustomSnackBar(
      context: context,
      message: message,
      backgroundColor: Colors.red.shade700,
      icon: Icons.error,
    );
  }

  static void showInfoSnackBar(BuildContext context, String message) {
    _showCustomSnackBar(
      context: context,
      message: message,
      backgroundColor: AppColors.primary,
      icon: Icons.info,
    );
  }

  static void _showCustomSnackBar({
    required BuildContext context,
    required String message,
    required Color backgroundColor,
    required IconData icon,
    Duration duration = const Duration(seconds: 3),
  }) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(icon, color: AppColors.white),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: AppTextStyles.descriptionText.copyWith(
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(12),
      duration: duration,
      action: SnackBarAction(
        label: "DISMISS",
        textColor: AppColors.white,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
