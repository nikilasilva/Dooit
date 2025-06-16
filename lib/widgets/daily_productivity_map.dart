import 'package:dooit/utils/app_styles.dart';
import 'package:dooit/widgets/productivity_heatmap.dart';
import 'package:flutter/material.dart';

class DailyProductivityMap extends StatelessWidget {
  const DailyProductivityMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Daily Productivity Map",
            style: AppTextStyles.subHeading2
          ),
          SizedBox(height: 20),

          ProductivityHeatmap(),
        ],
      ),
    );
  }
}
