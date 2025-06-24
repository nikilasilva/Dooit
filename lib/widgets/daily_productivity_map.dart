import 'package:dooit/providers/task_provider.dart';
import 'package:dooit/utils/app_styles.dart';
import 'package:dooit/widgets/productivity_heatmap.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DailyProductivityMap extends StatelessWidget {
  const DailyProductivityMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        // Get the completed tasks per day from the provider
        final completedTasksPerDay = taskProvider.completedTasksPerDay;

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Daily Productivity Map", style: AppTextStyles.subHeading2),
              SizedBox(height: 20),

              // Pass the actual data to the heatmap
              ProductivityHeatmap(completedTasksPerDay: completedTasksPerDay),
            ],
          ),
        );
      },
    );
  }
}
