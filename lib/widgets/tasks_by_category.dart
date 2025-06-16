import 'package:dooit/utils/app_styles.dart';
import 'package:dooit/widgets/category_bar_chart.dart';
import 'package:flutter/material.dart';

class TasksByCategory extends StatelessWidget {
  const TasksByCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tasks by Category",
            style: AppTextStyles.subHeading,
          ),
          SizedBox(height: 20),

          CategoryBarChartWidget(),
        ],
      ),
    );
  }
}
