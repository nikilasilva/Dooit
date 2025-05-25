import 'package:dooit/utils/app_styles.dart';
import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const CategoryButton({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.primary, size: 30),
          SizedBox(height: 6),
          Text(label, style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
