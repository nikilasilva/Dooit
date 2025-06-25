import 'package:DooIt/utils/app_styles.dart';
import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  final String title;
  final EdgeInsetsGeometry? padding;

  const CustomHeader({
    super.key,
    required this.title,
    this.padding = const EdgeInsets.fromLTRB(50, 50, 50, 20),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      color: AppColors.secondary,
      child: Padding(
        padding: padding!,
        child: Text(title, style: AppTextStyles.heading),
      ),
    );
  }
}
