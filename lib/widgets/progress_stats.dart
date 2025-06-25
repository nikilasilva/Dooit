import 'package:DooIt/utils/app_styles.dart';
import 'package:DooIt/widgets/circular_progress.dart';
import 'package:flutter/material.dart';

class ProgressStats extends StatelessWidget {
  final int completedToday;
  final int totalToday;
  final int streak;

  const ProgressStats({
    super.key,
    required this.completedToday,
    required this.totalToday,
    required this.streak,
  });

  @override
  Widget build(BuildContext context) {
    final taskText1 = completedToday == 1 ? 'task' : 'tasks';
    final taskText2 = totalToday == 1 ? 'task' : 'tasks';
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "You have completed",
                  style: AppTextStyles.descriptionText,
                ),
                SizedBox(height: 4),
                Text("$completedToday $taskText1 out of $totalToday $taskText2", style: AppTextStyles.descriptionText),
                SizedBox(height: 12),
                Text(
                  "Current streak: $streak days",
                  style: AppTextStyles.subHeading2,
                ),
              ],
            ),
          ),

          SizedBox(
            width: 90,
            height: 90,
            child: CircularProgress(completed: completedToday, total: totalToday, size: 90),
          ),
        ],
      ),
    );
  }
}
