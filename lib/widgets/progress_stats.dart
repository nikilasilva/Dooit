import 'package:dooit/utils/app_styles.dart';
import 'package:dooit/widgets/circular_progress.dart';
import 'package:flutter/material.dart';

class ProgressStats extends StatelessWidget {
  const ProgressStats({super.key});

  @override
  Widget build(BuildContext context) {
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
                Text("1 task out of 4", style: AppTextStyles.descriptionText),
                SizedBox(height: 12),
                Text(
                  "Current streak: 8 days",
                  style: AppTextStyles.subHeading2,
                ),
              ],
            ),
          ),

          SizedBox(
            width: 90,
            height: 90,
            child: CircularProgress(completed: 1, total: 4, size: 90,),
          )
          
        ],
      ),
    );
  }
}
