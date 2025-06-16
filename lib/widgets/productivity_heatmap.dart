import 'package:dooit/utils/app_styles.dart';
import 'package:dooit/widgets/heatmap_legend.dart';
import 'package:dooit/widgets/heatmap_week_row.dart';
import 'package:flutter/material.dart';
class ProductivityHeatmap extends StatelessWidget {
  const ProductivityHeatmap({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          // Month Headers
          Row(
            children: [
              SizedBox(width: 60),
              Expanded(
                child: Center(
                  child: Text(
                    "January",
                    style: AppTextStyles.subHeadingDark.copyWith(fontSize: 14),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    "February",
                    style: AppTextStyles.subHeadingDark.copyWith(fontSize: 14),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    "March",
                    style: AppTextStyles.subHeadingDark.copyWith(fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          
          // Week rows
          ...List.generate(4, (weekIndex) {
            return HeatmapWeekRow(weekIndex: weekIndex);
          }),
          
          SizedBox(height: 16),
          
          // Legend
          HeatmapLegend(),
        ],
      ),
    );
  }
}