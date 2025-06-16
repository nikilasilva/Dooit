// lib/utils/app_styles.dart
import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFFF8EFD9);
  static const Color primary = Color(0xFFF15A29);
  static const Color secondary = Color(0xFFF4EFCA);
  static const Color textDark = Colors.black87;
  static const Color white = Colors.white;
  static const Color grey1 = Colors.grey;
  static const Color red = Color(0xFFFF0000);
}

class AppTextStyles {
  static const TextStyle logoStyle = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static const TextStyle heading = TextStyle(
    fontSize: 35,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static const TextStyle subHeading = TextStyle(
    fontSize: 22,
    color: AppColors.primary,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle subHeading2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static const TextStyle headingDark = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
  );

  static const TextStyle subHeadingDark = TextStyle(
    fontSize: 18,
    color: AppColors.textDark,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  static const TextStyle linkStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 20,
    color: AppColors.white,
  );

  static TextStyle confirmationText = TextStyle(
    fontSize: 16,
    color: Colors.grey[700],
    height: 1.4,
  );

  static TextStyle descriptionText = TextStyle(
    fontSize: 15,
    color: Colors.grey[600],
    fontWeight: FontWeight.w500,
  );

  static const TextStyle buttonTextPrimary = TextStyle(
    fontSize: 16,
    color: AppColors.primary,
  );

  static const TextStyle inputFieldText = TextStyle(
    color: AppColors.primary,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle cancelText = TextStyle(
    color: AppColors.red,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
}

class AppButtonStyles {
  static final ButtonStyle primaryButton = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary,
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
  );

  static final ButtonStyle outlineButton = OutlinedButton.styleFrom(
    side: BorderSide(color: AppColors.primary),
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
  );
}
