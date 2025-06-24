import 'package:dooit/providers/task_provider.dart';
import 'package:dooit/utils/app_styles.dart';
import 'package:dooit/widgets/category_bar_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TasksByCategory extends StatelessWidget {
  const TasksByCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        final counts = taskProvider.taskCountByCategory;

        // Sort and take top 4
        final topCategories =
            counts.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
        final top4 = topCategories.take(4).toList();

        // Find the max value for scaling bars
        final maxValue =
            top4.isNotEmpty
                ? top4.map((e) => e.value).reduce((a, b) => a > b ? a : b)
                : 1;

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Tasks by Category", style: AppTextStyles.subHeading),
              SizedBox(height: 20),

              CategoryBarChartWidget(
                data: top4,
                maxValue: maxValue,
              ),
            ],
          ),
        );
      },
    );
  }
}
