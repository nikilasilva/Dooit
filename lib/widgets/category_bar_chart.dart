import 'package:dooit/utils/app_styles.dart';
import 'package:flutter/material.dart';

class CategoryBarChartWidget extends StatelessWidget {
  final List<MapEntry<String, int>> data;
  final int maxValue;

  const CategoryBarChartWidget({
    super.key,
    required this.data,
    required this.maxValue,
  });

  Widget _buildBarColumn(String category, int value, int maxValue) {
    double height =
        maxValue > 0 ? (value / maxValue) * 120 : 0; // Max height of 120

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: double.infinity,
            height: height,
            margin: EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
            ),
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
            margin: EdgeInsets.symmetric(horizontal: 2),
            child: Text(
              category,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          // Y-axis labels and bars
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Y-axis
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "$maxValue",
                      style: AppTextStyles.descriptionText.copyWith(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "${(maxValue * 2 / 3).round()}",
                      style: AppTextStyles.descriptionText.copyWith(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "${(maxValue / 3).round()}",
                      style: AppTextStyles.descriptionText.copyWith(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "0",
                      style: AppTextStyles.descriptionText.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 16),

                // Bars
                ...data.map(
                  (entry) => _buildBarColumn(entry.key, entry.value, maxValue),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
