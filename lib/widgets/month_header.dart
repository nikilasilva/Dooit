import 'package:DooIt/utils/app_styles.dart';
import 'package:flutter/material.dart';

class MonthHeader extends StatelessWidget {
  final DateTime currentMonth;
  final VoidCallback onPreviousMonth;
  final VoidCallback onNextMonth;

  const MonthHeader({
    super.key,
    required this.currentMonth,
    required this.onPreviousMonth,
    required this.onNextMonth,
  });

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: onPreviousMonth,
            icon: Icon(Icons.chevron_left, color: AppColors.primary, size: 28),
          ),
          Text(
            "${_getMonthName(currentMonth.month)} ${currentMonth.year}",
            style: AppTextStyles.subHeadingDark
          ),
          IconButton(
            onPressed: onNextMonth,
            icon: Icon(Icons.chevron_right, color: AppColors.primary, size: 28),
          ),
        ],
      ),
    );
  }
}
