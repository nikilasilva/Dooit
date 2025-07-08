import 'package:DooIt/utils/app_styles.dart';
import 'package:flutter/material.dart';

class CircularProgress extends StatelessWidget {
  final int completed;
  final int total;
  final double size;

  const CircularProgress({
    super.key,
    required this.completed,
    required this.total,
    this.size = 100,
  });

  @override
  Widget build(BuildContext context) {
    double progress = (total > 0) ? (completed / total) : 0.0;
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 8,
              backgroundColor: AppColors.grey1,
              valueColor: AlwaysStoppedAnimation(AppColors.primary),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Completed",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "$completed of $total",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
