import 'package:DooIt/utils/app_styles.dart';
import 'package:flutter/material.dart';

class ActionButtonsRow extends StatelessWidget {
  final VoidCallback? onCancel;
  final VoidCallback? onSubmit;
  final Color submitColor;
  final IconData submitIcon;

  const ActionButtonsRow({
    super.key,
    required this.onCancel,
    required this.onSubmit,
    this.submitColor = AppColors.primary,
    this.submitIcon = Icons.check,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Cancel Button
        GestureDetector(
          onTap: onCancel,
          child: Text('Cancel', style: AppTextStyles.cancelText),
        ),

        // Submit Button
        GestureDetector(
          onTap: onSubmit,
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: submitColor,
              shape: BoxShape.circle,
            ),
            child: Icon(submitIcon, color: AppColors.white, size: 32,),
          ),
        )
      ],
    );
  }
}
